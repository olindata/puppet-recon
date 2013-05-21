require 'puppet/face/autoscale'
require 'fog'

Puppet::Face.define :autoscale, '0.0.1' do
    action :listconfig do
        summary 'List autoscale launch configurations.'

        Puppet::CloudPack.add_list_options(self)

        when_invoked do |options|
            autoscale = Fog::AWS::AutoScaling.new(
                :region => options[:region]
            )

            autoscale.configurations
        end

        when_rendering :console do |value|
            value.collect do |hash|
                puts YAML::dump(hash)
            end
        end
    end

    action :listgroups do
        summary 'List autoscale groups.'

        Puppet::CloudPack.add_list_options(self)

        when_invoked do |options|
            autoscale = Fog::AWS::AutoScaling.new(
                :region => options[:region]
            )

            autoscale.groups
        end

        when_rendering :console do |value|
            value.collect do |hash|
                puts YAML::dump(hash)
            end
        end
    end

    action :listpolicies do
        summary 'List autoscale policies.'

        Puppet::CloudPack.add_list_options(self)

        when_invoked do |options|
            autoscale = Fog::AWS::AutoScaling.new(
                :region => options[:region]
            )

            autoscale.policies
        end

        when_rendering :console do |value|
            value.collect do |hash|
                puts YAML::dump(hash)
            end
        end
    end
end
