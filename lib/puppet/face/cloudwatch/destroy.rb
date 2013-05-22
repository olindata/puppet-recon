require 'puppet/cloudpack'
require 'puppet/face/cloudwatch'
require 'fog'

Puppet::Face.define :cloudwatch, '0.0.1' do
    action :destroy do
        summary 'Delete a CloudWatch alarm.'
        Puppet::CloudPack.add_list_options(self)

        when_invoked do |options|
            cw = Fog::AWS::CloudWatch.new(
                :region => options[:region]
            )

            alarm = cw.alarms.find { |hash| hash.id === 'testalarm' }

            unless alarm
                Puppet.err "Unable to delete, alarm does not exist"
                return nil
            end

            alarm.destroy
        end
    end
end
