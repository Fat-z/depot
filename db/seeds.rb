# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.delete_all
User.delete_all
Cart.delete_all
LineItem.delete_all

User.create(name: 'zhan',
  password: '123',
  password_confirmation: '123',
  identity: 'seller'
)

User.create(name: 'ni',
  password: '123',
  password_confirmation: '123',
  identity: 'seller'
)

User.create(name: 'guo',
  password: '123',
  password_confirmation: '123',
  identity: 'seller'
)

User.create(name: 'lc',
  password: '123',
  password_confirmation: '123',
  identity: 'seller'
)

Product.create(title: 'CoffeeScript',
  description: 
    %{<p>
        CoffeeScript is JavaScript done right. It provides all of JavaScript's
  functionality wrapped in a cleaner, more succinct syntax. In the first
  book on this exciting new language, CoffeeScript guru Trevor Burnham
  shows you how to hold onto all the power and flexibility of JavaScript
  while writing clearer, cleaner, and safer code.
      </p>},
  image_url:   'cs.jpg',    
  category: 'life',
  price: 36.00,
  publish: 'zhan')
  #publish: 'zhan63906')
# . . .

Product.create(title: 'Programming Ruby 1.9',
  description:
    %{<p>
        Ruby is the fastest growing and most exciting dynamic language
        out there. If you need to get working programs delivered fast,
        you should add Ruby to your toolbox.
      </p>},
  image_url: 'ruby.jpg',
  category: 'science',
  price: 49.95,
  publish: 'zhan')
# . . .

Product.create(title: 'Rails Test Prescriptions',
  description: 
    %{<p>
        <em>Rails Test Prescriptions</em> is a comprehensive guide to testing
        Rails applications, covering Test-Driven Development from both a
        theoretical perspective (why to test) and from a practical perspective
        (how to test effectively). It covers the core Rails testing tools and
        procedures for Rails 2 and Rails 3, and introduces popular add-ons,
        including Cucumber, Shoulda, Machinist, Mocha, and Rcov.
      </p>},
  image_url: 'rtp.jpg',
  category: 'science',
  price: 34.95,
  publish: 'ni')
  
Product.create(title: 'Sherlock Holmes',
  description: 
    %{<p>
        Since his first appearance in Beeton's Christmas Annual in 1887, 
        Sir Arthur Conan Doyle's Sherlock Holmes has been one of the most beloved 
        fictional characters ever created. Now, in two volumes, this new Bantam edition 
        presents all 56 short stories and 4 novels featuring Conan Doyle's classic hero
        truly complete collection now available in paperback! Volume I includes 
        the early novel, A Study in Scarlet, that introduced the eccentric genius of 
        Sherlock Holmes to the world. This baffling murder mystery, with the cryptic 
        word Rache written in blood, first brought Holmes with Dr. John Watson. 
      </p>},
  image_url: 'sherlock.jpg',
  category: 'literature',
  price: 21.95,
  publish: 'ni') 
  
Product.create(title: 'AP U.S. History',
  description: 
    %{<p>
      Completely revised and updated, this new edition reflects major changes 
      that have occurred on the AP World History exam since Fall 2011. Two 
      full-length model exams with answer keys Detailed advice on answering 
      the comparative essay question Strategies for answering the test s 
      multiple-choice and document-based questions A review of world history, 
      from the foundations of civilization circa. 8000 B.C. to world cultures 
      of the twenty-first century.
      </p>},
  image_url: 'us.jpg',
  category: 'culture',
  price: 98.10,
  publish: 'ni')
  
Product.create(title: 'Business Model Generation',
  description: 
    %{<p>
      You're holding a handbook for visionaries, game changers, and challengers
      striving to defy outmoded business models and design tomorrow's 
      enterprises. It's a book for the business model generation. 
      </p>},
  image_url: 'business.jpg',
  category: 'economic',
  price: 177.00,
  publish: 'lc')

Product.create(title: 'PHR and SPHR',
  description: 
    %{<p>
    Updated edition of best-selling guide for PHR and SPHR candidates The 
    demand for qualified human resources professionals is on the rise. The new 
    Professional in Human Resources (PHR) and Senior Professional in Human 
    Resources (SPHR) exams from the Human Resources Certification Institute (HRCI) 
    reflect the evolving industry standards for determining competence in the field 
    of HR. This new edition of the leading PHR/SPHR Study Guide reflects those 
    changes. Serving as an ideal resource for HR professionals who are seeking 
    to validate their skills and knowledge, this updated edition helps those 
    professionals prepare for these challenging exams. Features study tools that 
    are designed to reinforce understanding of key functional areas Provides access 
    to bonus materials, including a practice exam for the PHR as well as one for the SPHR.
      </p>},
  image_url: 'php.jpg',
  category: 'science',
  price: 55.45,
  publish: 'lc')

Product.create(title: 'Fifty Great Short Stories',
  description: 
    %{<p>
    50 Great Short Stories is a comprehensive selection from the world's finest 
    short fiction. The authors represented range from Hawthorne, Maupassant, and 
    Poe, through Henry James, Conrad, Aldous Huxley, and James Joyce, to Hemingway, 
    Katherine Anne Porter, Faulkner, E.B. 
      </p>},
  image_url: 'story.jpg',
  category: 'literature',
  price: 24.75,
  publish: 'guo')
  
Product.create(title: 'Eat and Run',
  description: 
    %{<p>
      Isolated by Mexico's deadly Copper Canyons, the blissful Tarahumara 
      Indians of have honed the ability to run hundreds of miles without rest 
      or injury. In a riveting narrative, award-winning journalist and 
      often-injured runner, Chris McDougall sets out to discover their secrets. 
      </p>},
  image_url: 'eat.jpg',
  category: 'life',
  price: 34.95,
  publish: 'guo')