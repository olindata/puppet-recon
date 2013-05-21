require 'puppet/cloudpack'
require 'puppet/face/autoscale'
require 'fog'

Puppet::Face.define :autoscale, '0.0.1' do
    action :destroyconfig do
        summary 'Delete an autoscale launch configuration.'

        Puppet::CloudPack.add_list_options(self)

        when_invoked do |options|
            autoscale = Fog::AWS::AutoScaling.new(
                :region => options[:region]
            )

            configuration = autoscale.configurations.find { |hash| hash.id === 'testautoscale' }

            unless configuration
                Puppet.err "Unable to delete, launch configuration does not exist"
                return nil
            end

            configuration.destroy
        end
    end

    action :destroygroup do
        summary 'Delete an autoscale group.'

        when_invoked do |options|
            autoscale = Fog::AWS::AutoScaling.new(
                :region => options[:region]
            )

            group = autoscale.groups.find { |hash| hash.id === 'test_group' }

            unless group
                Puppet.err "Unable to delete, autoscale group does not exist"
                return nil
            end

            group.destroy
        end
    end

    action :destroypolicy do
        summary 'Delete an autoscale policy.'

        when_invoked do |options|
            autoscale = Fog::AWS::AutoScaling.new(
                :region => options[:region]
            )

            policy = autoscale.policies.find { |hash| hash.id === 'test_group' }

            unless policy
                Puppet.err "Unable to delete, autoscale policy does not exist"
                return nil
            end

            policy.destroy
        end
    end
end
