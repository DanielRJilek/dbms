import pymysql
import getpass


def connect():
    try:
        username = input("Username: ")
        password = getpass.getpass("Password: ")
        cnx = pymysql.connect(host='localhost', user=username, 
            password=password,
            db='Kumar_Jilek_Logan_Database', charset='utf8mb4',
            cursorclass=pymysql.cursors.DictCursor)
        return cnx
    except RuntimeError:
        print("Incorrect username or password. Please try again.")
        cnx = connect()
    return cnx

def flight_menu():
    userchoice = 0
    userchoice = input("1 for flights, 2 for passengers, 3 for staff, 4 for aircraft:\n")
    return

def passenger_menu():
    return

def staff_menu():
    return

def aircraft_menu():
    return

def main():
    cnx = connect()
    cur = cnx.cursor()
    userchoice = 0
    userchoice = input("1 for flights, 2 for passengers, 3 for staff, 4 for aircraft:\n")
    if userchoice == '1':
        flight_menu()
    elif userchoice == '2':
        passenger_menu()
    elif userchoice == '3':
        staff_menu()
    elif userchoice == '4':
        aircraft_menu()


if __name__ == "__main__":
    main()