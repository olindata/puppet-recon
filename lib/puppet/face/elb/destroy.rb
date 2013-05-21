require 'puppet/cloudpack'
require 'puppet/face/elb'
require 'fog'

Puppet::Face.define :elb, '0.0.1' do
    action :destroy do
        summary 'Delete an elastic load balancer.'

        Puppet::CloudPack.add_list_options(self)

        when_invoked do |options|
            elb = Fog::AWS::ELB.new(
                :region => options[:region]
            )

            balancer = elb.load_balancers.find { |hash| hash.id === 'testbalancer' }

            unless balancer 
                Puppet.err "Unable to delete, load balancer does not exist"
                return nil
            end

            balancer.destroy
        end
    end
end
