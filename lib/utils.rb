require "yaml"

module Utils
  def symbolize_keys(hash)
    hash.keys.each do |key|
      hash[(key.to_sym rescue key) || key] = hash.delete(key)
    end
    hash
  end

  def debug(obj)
    YAML::ENGINE.yamler = 'syck'
    trace = YAML::dump(obj)
    trace.gsub!(/\n(.*):\n/, "\n"+'<span style="color:#333;">\1 </span>'+"\n")
    trace.gsub!(/\n(.*):\s/, "\n"+'<span style="color:#333;">\1 </span>')
    <<-eos
      <pre style="text-align:left;
      font-family:Monaco,Sans;
      font-weight:normal;
      background-color:#efefef;
      padding:15px;
      color:#777;
      font-size:13px;
      white-space:pre;
      display:block;
      overflow:auto;
      line-height:16px;
      font-weight:normal;">#{trace}</pre>
    eos
  end
end

class String
  def is_i?
     !!(self =~ /^[-+]?[0-9]+$/)
  end
end

class Hash
  def with_defaults(defaults)
    self.merge(defaults) { |key, old, new| old.nil? ? new : old } 
  end

  def with_defaults!(defaults)
    self.merge!(defaults) { |key, old, new| old.nil? ? new : old }
  end
end


