Puppet::Type.newtype :consulhead, :is_capability => true do
 newparam :name, :is_namevar => true
 newparam :head_ip
 newparam :datacenter
end
