class Resource
  class Server 
    class EC2 < Server
      
      default_action :create
      resource_name :ec2_server
      provider_name :ec2_server
      
      attribute :aws_access_key_id, String, :required => true
      attribute :aws_secret_access_key, String, :required => true
      attribute :image_id, String
      attribute :key_name, String
      attribute :ami_launch_index, Numeric
      attribute :availability_zone, String, :default => 'us-east-1a'
      attribute :region, String, :default => 'us-east-1'
      attribute :block_device_mapping, Object
      attribute :client_token, String
      attribute :dns_name, String
      attribute :groups, Object, :default => [ 'default' ]
      attribute :flavor_id, String
      attribute :instance_id, String
      attribute :kernel_id, String
      attribute :created_at, DateTime
      attribute :monitoring, [ TrueClass, FalseClass ], :default => false
      attribute :placement_group, String
      attribute :platform, String
      attribute :product_codes, Object
      attribute :private_dns_name, String
      attribute :private_ip_address, String
      attribute :public_ip_address, String
      attribute :ramdisk_id, String
      attribute :reason, String
      attribute :root_device_name, String
      attribute :root_device_type, String
      attribute :state, String
      attribute :state_reason, Object
      attribute :subnet_id, String
      attribute :tenancy, String
      attribute :tags, Object
      attribute :user_data, String
    end
    
  end
end