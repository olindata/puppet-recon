require 'puppet/cloudpack'
require 'puppet/face/autoscale'
require 'fog'

Puppet::Face.define :autoscale, '0.0.1' do
    action :createconfig do
        summary "Create an autoscale launch configuration."

        Puppet::CloudPack.add_list_options(self)

        when_invoked do |options|
            autoscale = Fog::AWS::AutoScaling.new(
                :region => options[:region]
            )

            configuration = autoscale.configurations.create(
                :id              => 'testautoscale',
                :image_id        => 'ami-867d3ed4',
                :instance_type   => 'm1.small',
                :security_groups => [ 'all-access' ],
                :key_name        => 'rajkissu'
            )
        end
    end

    action :creategroup do
        summary "Create an autoscale group."

        Puppet::CloudPack.add_list_options(self)

        when_invoked do |options|
            autoscale = Fog::AWS::AutoScaling.new(
                :region => options[:region]
            )

            configuration = autoscale.configurations.find { |hash| hash.id === 'testautoscale' }

            unless configuration
                Puppet.err "Launch configuration does not exist"
                return nil
            end

            group = autoscale.groups.create(
                :id => 'test_group',
                :availability_zones => %w(ap-southeast-1a ap-southeast-1b),
                :launch_configuration_name => configuration.id,
                :min_size => 0,
                :max_size => 2,
                :desired_capacity => 0
            )
        end
    end

    action :createpolicy do
        summary "Create an autoscale policy."

        Puppet::CloudPack.add_list_options(self)

        when_invoked do |options|
            autoscale = Fog::AWS::AutoScaling.new(
                :region => options[:region]
            )

            configuration = autoscale.configurations.find { |hash| hash.id === 'testautoscale' }

            unless configuration
                Puppet.err "Launch configuration does not exist"
                return nil
            end

            group = autoscale.policies.create()
        end
    end
end
