# == Schema Information
#
# Table name: cats
#
#  id          :integer      not null, primary key
#  name        :string
#  color       :string
#  breed       :string
#
# Table name: toys
#
#  id          :integer      not null, primary key
#  name        :string
#  color       :string
#  price       :integer
#
# Table name: cat_toys
#
#  id          :integer      not null, primary key
#  cat_id      :integer      not null, foriegn key
#  toy_id      :integer      not null, foreign key

require_relative '../data/pg_helper.rb'

def freyja
  # Find the names of all the cats that are the same color as the cat named
  # `Freyja`. Do not include `Freyja` in the results. Sort by cat name
  # alphabetically.

  execute(<<-SQL)
  SELECT
    cats.name
  FROM
    cats
  WHERE
  cats.color IN
  (SELECT
    cats.color
  FROM
    cats
  WHERE
    cats.name = 'Freyja') AND NOT cats.name = 'Freyja'
  ORDER BY
    cats.name;

  SQL
end

def find_unknown
  # Find all the toys names that belong to the cat who's breed is `Unknown`.
  # Only return the toys that have more than one word in the name.
  # Order from the most expensive to least.

  execute(<<-SQL)
  
  SELECT
    toys.name
  FROM
    toys
  JOIN
    cat_toys ON cat_toys.toy_id = toys.id
  JOIN 
    cats ON cats.id = cat_toys.cat_id
  WHERE
    cats.breed = 'Unknown' AND toys.name LIKE '% %'
  ORDER BY
    toys.price DESC;


  SQL
end

def five_cheap_toys
  # Find the name and prices for the five cheapest toys.
  # Order by toy price from most expensive to least.

  execute(<<-SQL)
  SELECT
  toys.name, toys.price AS 5_cheapest
  FROM
  toys
  ORDER BY
  toys.price
  LIMIT
  5

  SELECT
  *
  FROM
  5_cheapest
  ORDER BY
  toys.price DESC;

  SQL
end

def rich_crypto_cats
  # `Bitcoin Cash` became a really popular toy sold at different prices.
  # Find the lowest price of the toy `Bitcoin Cash`.
  # List the names of the cats who acquired the toy at its lowest price.
  # Order by the cat name alphabetically.

  execute(<<-SQL)
  SELECT
  cats.name
  FROM
  cats
  JOIN
  cat_toys ON cat_toys.cat_id = cats.id
  JOIN
  toys ON toys.id = cat_toys.toy_id
  WHERE
  toys.name = 'Bitcoin Cash' AND toys.price =
  (SELECT
    MIN(toys.price) AS low_price
  FROM
    toys
  WHERE
    toys.name = 'Bitcoin Cash')
  ORDER BY
  cats.name;

  SQL
end

def toy_that_jet_owns
  # Find the most expensive toy that is owned by the cat named `Jet`.
  # Find the cats that own toys of the same name.
  # List the name of the cat and the name of the toy.
  # Exclude Jet from the results.
  # Order by cat name alphabetically.

  execute(<<-SQL)
  SELECT
  cats.name, toys.name
  FROM
  cats
  JOIN
  cat_toys ON cat_toys.cat_id = cats.id
  JOIN
  toys ON toys.id = cat_toys.toy_id
  WHERE
  toys.name IN 
  (SELECT
  toys.name
  FROM
  toys
  JOIN
    cat_toys ON cat_toys.toy_id = toys.id
  JOIN 
    cats ON cats.id = cat_toys.cat_id
  WHERE
  cats.name = 'Jet'
  ORDER BY
    toys.price DESC
  LIMIT
    1)
  ORDER BY
  cats.name;
  

  SQL
end