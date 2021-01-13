class Dog 
  
  attr_accessor :name, :breed 
  attr_reader :id 
  
  def initialize(id: nil, name:, breed:)
    @id = id
    @name = name
    @breed = breed
  end
  
  def self.create_table
    dog = <<-SQL
    CREATE TABLE dogs (
    id INTEGER PRIMARY KEY,
    name TEXT,
    breed TEXT)
    SQL
    
    DB[:conn].execute(dog)
  end
  
  def self.drop_table
    DB[:conn].execute('DROP TABLE dogs')
  end
  
  def save
    # binding.pry
    dog = <<-SQL 
    INSERT INTO dogs (name, breed)
    VALUES (?,?)
    SQL
    
    DB[:conn].execute(dog, self.name, self.breed)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    self
  end
  
  def self.create(attributes)
    doggo = new(attributes)
    doggo.save
    doggo
  end
  
  def self.new_from_db(pupper)
    doggo = new(id: pupper[0], name: pupper[1], breed: pupper[2])
    doggo
  end
  
  def self.find_by_id(id)
    binding.pry
  end
  
  
  
end 