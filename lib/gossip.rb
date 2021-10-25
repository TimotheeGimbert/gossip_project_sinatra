class Gossip

  attr_accessor :author, :content, :comments

  def initialize(author, content, comments)
    @author = author
    @content = content
    @comments = Array.new
  end
  
  def save
    CSV.open("./db/gossips.csv", "ab") do |csv|
      csv << [@author, @content, @comments]
    end
  end

  def self.all
    gossips = Array.new
    CSV.read("./db/gossips.csv").each do |line|
      gossips << Gossip.new(line[0], line[1], line[2])
    end
    puts gossips.to_s
    return gossips
  end

  def self.find(id)
    gossip_ary = CSV.read("./db/gossips.csv")[id.to_i-1]
    gossip = Gossip.new(gossip_ary[0], gossip_ary[1], gossip_ary.slice(2..-1))
    return gossip
  end

  def self.update(id, author, content)
    gossips = self.all
    gossips[id-1].author = author
    gossips[id-1].content = content
    
    CSV.open("./db/gossips.csv", "w")
    gossips.each do |gossip|
      CSV.open("./db/gossips.csv", "ab") do |csv|
        csv << [gossip.author, gossip.content, gossip.comments]
      end
    end

  end
  
end