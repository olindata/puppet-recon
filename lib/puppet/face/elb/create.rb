require 'puppet/cloudpack'
require 'puppet/face/elb'
require 'fog'

Puppet::Face.define :elb, '0.0.1' do
    action :create do
        summary "Create an Elastic load balancer."

        when_invoked do |options|
            elb = Fog::AWS::ELB.new(
                :region => options[:region]
            )

            balancer = elb.load_balancers.create(
            )
        end
    end
end
