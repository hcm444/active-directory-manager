Import-Module ActiveDirectory

# Create a new AD user
Function New-ADUser {
  param ($username, $password, $firstname, $lastname)

  try {
    # Create an NTAccount object with the specified username
    $user = New-Object System.Security.Principal.NTAccount($username)
    
    # Get the distinguished name of the user
    $userDN = (Get-ADUser $user).DistinguishedName
    
    # Create a new AD user with the specified details
    New-ADUser -SamAccountName $username -UserPrincipalName "$username@domain.com" -Name "$firstname $lastname" -GivenName $firstname -Surname $lastname -Enabled $True -PasswordNeverExpires $True -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force)
    
    Write-Output "User $username created successfully."
  } catch {
    Write-Error "Error creating user $username: $_"
  }
}

# Update an existing AD user
Function Set-ADUser {
  param ($username, $firstname, $lastname)
  
  try {
    # Create an NTAccount object with the specified username
    $user = New-Object System.Security.Principal.NTAccount($username)
    
    # Get the distinguished name of the user
    $userDN = (Get-ADUser $user).DistinguishedName
    
    # Update the specified user with the given first and last names
    Set-ADUser $userDN -GivenName $firstname -Surname $lastname
    
    Write-Output "User $username updated successfully."
  } catch {
    Write-Error "Error updating user $username: $_"
  }
}

# Delete an existing AD user
Function Remove-ADUser {
  param ($username)
  
  try {
    # Create an NTAccount object with the specified username
    $user = New-Object System.Security.Principal.NTAccount($username)
    
    # Get the distinguished name of the user
    $userDN = (Get-ADUser $user).DistinguishedName
    
    # Delete the specified user
    Remove-ADUser $userDN
    
    Write-Output "User $username deleted successfully."
  } catch {
    Write-Error "Error deleting user $username: $_"
  }
}
