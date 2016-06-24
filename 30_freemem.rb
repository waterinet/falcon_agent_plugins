#!/usr/bin/ruby

require 'json'

def main
	loop {
		puts "[" + get_memfree + "]"
		sleep 30
	}

end

class AgentData
	attr_accessor :metric
	attr_accessor :endpoint
	attr_accessor :tags
	attr_accessor :value
	attr_accessor :timestamp
	attr_accessor :step
	attr_accessor :counterType
	def to_json
		tmp_hash = { 
			"metric" => @metric,
			"endpoint" => @endpoint,
			"tags" => @tags,
			"value" => @value,
			"timestamp" => @timestamp,
			"step" => @step,
			"counterType" => @counterType
		}
        JSON.generate(tmp_hash)
	end
end

def get_memfree
    mem_info = %x(free)
	hostname = %x(hostname)

    a1 = AgentData.new
    a1.metric = "rb.mem.free"
    a1.endpoint = hostname.delete("\n")
    a1.tags=""
    a1.value = mem_info.split(" ")[9].to_i
    a1.timestamp = Time.now.to_i
    a1.step = 60
    a1.counterType = "GAUGE"
	return a1.to_json
end


main

