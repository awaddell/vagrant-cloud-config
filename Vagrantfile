
required_plugins = %w( vagrant-aws )

required_plugins.each do |plugin|
  system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

 
Vagrant.configure("2") do |config|
  
    config.vm.box = "dummy"
    config.vm.provider :aws do |aws, override|
        aws.region = "ap-southeast-2"
        aws.availability_zone = "ap-southeast-2b"
        aws.instance_type = "t2.micro"
        # aws.ami =  "ami-6d1c6657" # Ubuntu 12.04LTS daily build HVM
        # aws.ami =  "ami-7163104b" # Ubuntu 14.04.2 LTS
        aws.ami =  "ami-bd523087" # centos 7 09/29/2014  NB t1.micro is not enabled for this AMI # login as centos
        # aws.ami =  "ami-b3523089" # centos 6 09/29/2014    NB t1.micro is not enabled for this AMI # login as root
        aws.keypair_name = ENV['AWS_KEYPAIR_NAME']
        aws.access_key_id = ENV['AWS_ACCESS_KEY_ID']
        aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
        aws.subnet_id = "subnet-e09e8e82"    
        aws.private_ip_address = "172.31.0.11"
        aws.security_groups = ["sg-c69183a4"]
        override.ssh.username = "centos"
        override.ssh.private_key_path = ENV['AWS_PRIVATE_KEY_PATH']
        # NB we share the same user_data (cloud-init config) with Cloudformation
        # cloud-init gives the minumum, common config
        aws.user_data = File.read("user_data.txt")
        # don't leave old volumes hanging around 
        aws.block_device_mapping = [
            { 'DeviceName' => '/dev/sda1',
            'Ebs.VolumeSize' => 8, 
            'Ebs.DeleteOnTermination' => true 
            }
        ]
        aws.tags = {
          'Name' => 'web',
          'Stopalizer' => 'false'
        }
    end
   
    config.vm.synced_folder "./", "/vagrant", disabled: true

end
