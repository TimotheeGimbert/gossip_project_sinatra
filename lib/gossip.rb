class Gossip

  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end
  
  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    gossips = Array.new
    CSV.read("./db/gossip.csv").each do |line|
      gossips << Gossip.new(line[0], line[1])
    end
    return gossips
  end

end