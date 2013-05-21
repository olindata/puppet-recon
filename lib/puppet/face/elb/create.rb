require 'puppet/cloudpack'
require 'puppet/face/elb'
require 'fog'

Puppet::Face.define :elb, '0.0.1' do
    action :create do
        summary "Create an elastic load balancer."

        Puppet::CloudPack.add_list_options(self)

        when_invoked do |options|
            elb = Fog::AWS::ELB.new(
                :region => options[:region]
            )

            balancer = elb.load_balancers.create(
                :id => 'testbalancer',
                :availability_zones => [ 'ap-southeast-1a', 'ap-southeast-1b' ]
            )
        end
    end
end
