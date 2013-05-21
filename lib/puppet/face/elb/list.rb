require 'puppet/cloudpack'
require 'puppet/face/elb'
require 'fog'

Puppet::Face.define :elb, '0.0.1' do
    action :list do
        summary "List Elastic load balancers."

        Puppet::CloudPack.add_list_options(self)

        when_invoked do |options|
            elb = Fog::AWS::ELB.new(
                :region => options[:region]
            )

            elb.load_balancers
        end

        when_rendering :console do |value|
            value.collect do |hash|
                hc = hash.health_check
                "#{hash.id}:\n" +
                "    Availability Zones:\n" +
                hash.availability_zones.collect do |zone|
                    "        #{zone}"
                end.sort.join("\n") +
                "\n    Health Check:\n" +
		hc.map { |key,val|
		    "        #{key}: #{val}"
		}.join("\n")
            end.sort.join("\n\n")
        end
    end
end
