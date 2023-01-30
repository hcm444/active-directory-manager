Import-Module ActiveDirectory

# Create a new AD user
Function New-ADUser {
  param ($username, $password, $firstname, $lastname)
  $user = New-Object System.Security.Principal.NTAccount($username)
  $userDN = (Get-ADUser $user).DistinguishedName
  New-ADUser -SamAccountName $username -UserPrincipalName "$username@domain.com" -Name "$firstname $lastname" -GivenName $firstname -Surname $lastname -Enabled $True -PasswordNeverExpires $True -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force)
}

# Update an existing AD user
Function Set-ADUser {
  param ($username, $firstname, $lastname)
  $user = New-Object System.Security.Principal.NTAccount($username)
  $userDN = (Get-ADUser $user).DistinguishedName
  Set-ADUser $userDN -GivenName $firstname -Surname $lastname
}

# Delete an existing AD user
Function Remove-ADUser {
  param ($username)
  $user = New-Object System.Security.Principal.NTAccount($username)
  $userDN = (Get-ADUser $user).DistinguishedName
  Remove-ADUser $userDN
}
