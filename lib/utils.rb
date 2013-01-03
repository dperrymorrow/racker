module Utils
  def symbolize_keys(hash)
    hash.keys.each do |key|
      hash[(key.to_sym rescue key) || key] = hash.delete(key)
    end
    hash
  end
end

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
    trace.gsub!(/\n(.*):\n/, "\n"+'<span style="color:#75879d;">\1 </span>'+"\n")
    trace.gsub!(/\n(.*):\s/, "\n"+'<span style="color:#f9ee98;">\1 </span>')
    <<-eos
      <pre style="text-align:left;
      font-family:Monaco,Sans;
      font-weight:normal;
      background-color:#1a1a1a;
      padding:15px;
      color:#cf6a47;
      font-size:13px;
      white-space:pre;
      display:block;
      overflow:auto;
      line-height:16px;
      font-weight:normal;">#{trace}</pre>
    eos
  end
  
end

