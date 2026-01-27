#Definir variáveis
$resourceGroup = "meuGrupoRecursos"
$local = "East US"
$mSubNet = "minhaSubRede"
$vmVnet = "minhaVnet"
$sgName = "meuGrupoSeguranca"
$nomePC = "meuUbuntu"
$vmName = "minhaVM"

#Cria o grupo de recursos
New-AzResourceGroup -Name $resourceGroup -Location $local

# Create a subnet configuration
$subnetConfig = New-AzVirtualNetworkSubnetConfig `
  -Name $mSubNet `
  -AddressPrefix 192.168.1.0/24

# Create a virtual network
$vnet = New-AzVirtualNetwork `
  -ResourceGroupName $resourceGroup `
  -Location $local `
  -Name $vmVnet `
  -AddressPrefix 192.168.0.0/16 `
  -Subnet $subnetConfig

# Cria um endereço IP público e um DNS
$pip = New-AzPublicIpAddress `
  -ResourceGroupName $resourceGroup `
  -Location $local `
  -AllocationMethod Static `
  -IdleTimeoutInMinutes 4 `
  -Name "meudns$(Get-Random)"

# Cria um grupo de segurança de entrada para porta 22
$nsgRuleSSH = New-AzNetworkSecurityRuleConfig `
-Name "minhaRegraSegurancaSSH"  `
-Protocol "Tcp" `
-Direction "Inbound" `
-Priority 1000 `
-SourceAddressPrefix * `
-SourcePortRange * `
-DestinationAddressPrefix * `
-DestinationPortRange 22 `
-Access "Allow"

# Cria um grupo de segurança de entrada para porta 80
$nsgRuleWeb = New-AzNetworkSecurityRuleConfig `
-Name "minhaRegraSegurancaWWW"  `
-Protocol "Tcp" `
-Direction "Inbound" `
-Priority 1001 `
-SourceAddressPrefix * `
-SourcePortRange * `
-DestinationAddressPrefix * `
-DestinationPortRange 80 `
-Access "Allow"

# Cria um grupo de seguranca de rede
$nsg = New-AzNetworkSecurityGroup `
-ResourceGroupName $resourceGroup `
-Location $local `
-Name $sgName `
-SecurityRules $nsgRuleSSH,$nsgRuleWeb

# Create a virtual network card and associate with public IP address and NSG
$nic = New-AzNetworkInterface `
  -Name "minhaPlacaRede" `
  -ResourceGroupName $resourceGroup `
  -Location $local `
  -SubnetId $vnet.Subnets[0].Id `
  -PublicIpAddressId $pip.Id `
  -NetworkSecurityGroupId $nsg.Id

# Define um objeto para credencial de segurança
$securePassword = ConvertTo-SecureString ' ' -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ("azureuser", $securePassword)

# Cria a configuração da máquina virtual
$vmConfig = New-AzVMConfig `
  -VMName $vmName `
  -VMSize "Standard_B1s" | `
Set-AzVMOperatingSystem `
  -Linux `
  -ComputerName $nomePC `
  -Credential $cred `
  -DisablePasswordAuthentication | `
Set-AzVMSourceImage `
  -PublisherName "Canonical" `
  -Offer "UbuntuServer" `
  -Skus "18_04-lts-gen2" `
  -Version "latest" | `
Add-AzVMNetworkInterface `
  -Id $nic.Id

# Configura a chave SSH 
$sshPublicKey = cat ./minhachave.pub
Add-AzVMSshPublicKey `
  -VM $vmconfig `
  -KeyData $sshPublicKey `
  -Path "/home/azureuser/.ssh/authorized_keys" 

  #Cria a máquina virtual
New-AzVM `
  -ResourceGroupName $resourceGroup `
  -Location $local -VM $vmConfig
