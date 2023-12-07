# In this file you must implement your main query methods
# so they can be used by your database models to interact with your bot.

import os
import pymysql.cursors

# note that your remote host where your database is hosted
# must support user permissions to run stored triggers, procedures and functions.
db_host = os.environ["DB_HOST"]
db_username = os.environ["DB_USER"]
db_password = os.environ["DB_PASSWORD"]
db_name = os.environ["DB_NAME"]


class Database:

  @staticmethod
  def connect():
    try:
      conn = pymysql.connect(host=db_host,
                             port=3306,
                             user=db_username,
                             password=db_password,
                             db=db_name,
                             charset="utf8mb4",
                             cursorclass=pymysql.cursors.DictCursor)
      print("Bot connected to database {}".format(db_name))
      return conn
    except Exception as e:
      print(f"An error has occurred: {e}")

  #TODO: needs to implement the internal logic of all the main query operations
  def get_response(self, query, values=None, fetch=False, many_entities=False):
    """
        query: the SQL query with wildcards (if applicable) to avoid injection attacks
        values: the values passed in the query
        fetch: If set to True, then the method fetches data from the database (i.e with SELECT)
        many_entities: If set to True, the method can insert multiple entities at a time.
        """
    connection = self.connect()
    # your code here
    response = None
    return response

  @staticmethod
  def select(query, values=None):
    connection = Database.connect()
    if connection is None:
      print("Failed to connect to the database.")
      return None
    try:
      with connection.cursor() as cursor:
        cursor.execute(query, values)
        result = cursor.fetchall()
        print(
            f"Query executed successfully: {query} with values {values}, Result: {result}"
        )
        return result
    except Exception as e:
      print(f"An error occurred while executing the query: {e}")
    finally:
      if connection:
        connection.close()

  @staticmethod
  def insert(query, values=None):
    connection = Database.connect()
    if connection is None:
      print("Failed to connect to the database.")
      return None

    try:
      with connection.cursor() as cursor:
        cursor.execute(query, values)
        inserted_id = cursor.lastrowid  # Get the last inserted ID
        connection.commit()
      return inserted_id
    except Exception as e:
      print(f"An error occurred while executing the query: {e}")
    finally:
      if connection:
        connection.close()

  @staticmethod
  def update(query, values=None):
    connection = Database.connect()
    if connection is None:
      print("Failed to connect to the database.")
      return False

    try:
      with connection.cursor() as cursor:
        cursor.execute(query, values)
        connection.commit()
      return True
    except Exception as e:
      print(f"An error occurred while executing the query: {e}")
      return False
    finally:
      if connection:
        connection.close()

  @staticmethod
  def delete(query, values=None):
    connection = Database.connect()
    if connection is None:
      print("Failed to connect to the database.")
      return False

    try:
      with connection.cursor() as cursor:
        cursor.execute(query, values)
        connection.commit()
      return True
    except Exception as e:
      print(f"An error occurred while executing the query: {e}")
      return False
    finally:
      if connection:
        connection.close()

  @staticmethod
  def execute(query, values=None):
    connection = Database.connect()
    if connection is None:
      print("Failed to connect to the database.")
      return False

    try:
      with connection.cursor() as cursor:
        cursor.execute(query, values)
        connection.commit()
      return True
    except Exception as e:
      print(f"An error occurred while executing the query: {e}")
      return False
    finally:
      if connection:
        connection.close()
