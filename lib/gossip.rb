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

  def self.update(id, author, content)
    gossips = self.all
    gossips[id-1].author = author
    gossips[id-1].content = content
    CSV.open("./db/gossips.csv", "w")
    gossips.each do |gossip|
      CSV.open("./db/gossips.csv", "ab") do |csv|
        csv << [gossip.author, gossip.content]
      end
    end

  end
  
end