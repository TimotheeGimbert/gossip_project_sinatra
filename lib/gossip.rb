class Gossip

  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end
  
  def save
    CSV.open("./db/gossips.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    gossips = Array.new
    CSV.read("./db/gossips.csv").each do |line|
      gossips << Gossip.new(line[0], line[1])
    end
    return gossips
  end

  def self.find(id)
    gossip_ary = CSV.read("./db/gossips.csv")[id.to_i-1]
    gossip = Gossip.new(gossip_ary[0], gossip_ary[1])
    return gossip
  end

  
end