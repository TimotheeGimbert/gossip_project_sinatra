class Gossip

  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end
  
  def save
  # save a gossip instance into DATABASE
    CSV.open("./db/gossips.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
  # returns an array of all gossip instances in DATABASE
    gossips = Array.new
    CSV.read("./db/gossips.csv").each do |line|
      gossips << Gossip.new(line[0], line[1])
    end
    return gossips
  end

  def self.find(id)
  # returns the gossip from given id
    gossip_ary = CSV.read("./db/gossips.csv")[id.to_i-1]
    gossip = Gossip.new(gossip_ary[0], gossip_ary[1])
    return gossip
  end

  def self.update(id, author, content)
  # modification of an instance of gossip in the DATABASE
    gossips = self.all # gets all instances from DATABASE to an array
    gossips[id-1].author = author # modify the correct entry
    gossips[id-1].content = content
    CSV.open("./db/gossips.csv", "w") # erase the DATABASE (that's sick dude...!)
    gossips.each do |gossip| # for each temp saved instance, fills the CSV
      CSV.open("./db/gossips.csv", "ab") do |csv|
        csv << [gossip.author, gossip.content]
      end
    end

  end
  
end