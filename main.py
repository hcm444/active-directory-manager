import ldap

class ActiveDirectoryManager:
    def __init__(self, server, username, password):
        self.server = server
        self.username = username
        self.password = password
        self.conn = None

    def connect(self):
        try:
            self.conn = ldap.initialize(self.server)
            self.conn.simple_bind_s(self.username, self.password)
        except ldap.LDAPError as e:
            print("Failed to connect to Active Directory: ", e)

    def search(self, base_dn, search_filter):
        try:
            result = self.conn.search_s(base_dn, ldap.SCOPE_SUBTREE, search_filter)
            return result
        except ldap.LDAPError as e:
            print("Failed to search Active Directory: ", e)
            return None

    def add_user(self, dn, attributes):
        try:
            self.conn.add_s(dn, attributes)
        except ldap.LDAPError as e:
            print("Failed to add user to Active Directory: ", e)

if __name__ == "__main__":
    ad = ActiveDirectoryManager("ldap://localhost:389", "cn=admin,dc=example,dc=com", "secret")
    ad.connect()
    result = ad.search("dc=example,dc=com", "(objectClass=*)")
    print(result)
