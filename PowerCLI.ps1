# PowerCLIスナップイン読込
Add-PSSnapin VMware.VimAutomation.Core
# バージョン表示
Get-PowerCLIVersion

# vCenterアドレス、ユーザ名、パスワード入力
$Ip = Read-Host "Please enter vCenter name"
$User = Read-Host "Please enter username"
$Pass = Read-Host "Please enter password"

# vCenter接続
$Server = Connect-VIServer -Server $Ip -User $User -Password $Pass

# メニュー表示
while(1){
    Clear-Host
    Write-Output ' 1:Get-Folder'
    Write-Output ' 2:New-Folder'
    Write-Output ' 3:Remove-Folder'
    Write-Output ' 4:Get-Datacenter'
    Write-Output ' 5:New-Datacenter'
    Write-Output ' 6:Remove-Datacenter'
    Write-Output ' 7:Get-VMHost'
    Write-Output ' 8:Add-VMHost'
    Write-Output ' 9:Remove-VMHost'
    Write-Output '10:Get-VDSwitch'
    Write-Output '11:New-VDSwitch'
    Write-Output '12:Remove-VDSwitch'
    Write-Output '13:Get-VDSwitchVMHost'
    Write-Output '14:Add-VDSwitchVMHost'
    Write-Output '15:Remove-VDSwitchVMHost'
    Write-Output '16:Get-VMHostNetworkAdapter'
    Write-Output '17:Add-VDSwitchPhysicalNetworkAdapte'
    Write-Output '18:Remove-VDSwitchPhysicalNetworkAdapter'
    Write-Output '19:Get-VDPortGroup'
    Write-Output '20:New-VDPortgroup'
    Write-Output '21:Remove-VDPortGroup'
    Write-Output '99:Manual'
    Write-Output ' 0:Exit'
    $x = Read-Host "Please enter number"
    switch($x){
        1 {
            # フォルダ取得
            Clear-Host
            Get-Folder -NoRecursion
            $x = Read-Host "Press any key to continue ..."
        }
        2 {
            # フォルダ作成
            Clear-Host
            $Folder = Read-Host "Please enter Folder name"
            New-Folder -Name $Folder
            $x = Read-Host "Press any key to continue ..."
        }
        3 {
            # フォルダ削除
            Clear-Host
            $Folder = Read-Host "Please enter Folder name"
            Remove-Folder $Folder -Confirm:$False
            $x = Read-Host "Press any key to continue ..."
        }
        4 {
            # データセンタ取得
            Clear-Host
            Get-Datacenter
            $x = Read-Host "Press any key to continue ..."
        }
        5 {
            # データセンタ作成
            Clear-Host
            $Folder = Read-Host "Please enter Folder name"
            $Datacenter = Read-Host "Please enter Datacenter name"
            New-Datacenter -Location $Folder -Name $Datacenter
            $x = Read-Host "Press any key to continue ..."
        }
        6 {
            # データセンタ削除
            Clear-Host
            $Datacenter = Read-Host "Please enter Datacenter name"
            Remove-Datacenter $Datacenter -Confirm:$False
            $x = Read-Host "Press any key to continue ..."
        }
        7 {
            # VMホスト取得
            $Datacenter = Read-Host "Please enter Datacenter name"
            Clear-Host
            Get-VMHost -Location $Datacenter
            $x = Read-Host "Press any key to continue ..."
        }
        8 {
            # VMホスト追加
            Clear-Host
            $Ip = Read-Host "Please enter VMHost name"
            $User = Read-Host "Please enter username"
            $Pass = Read-Host "Please enter password"
            $Datacenter = Read-Host "Please enter Datacenter name"
            Add-VMHost $Ip -Location $Datacenter -User $User -Password $Pass
            $x = Read-Host "Press any key to continue ..."
        }
        9 {
            # VMホスト削除
            Clear-Host
            $Ip = Read-Host "Please enter VMHost name"
            Remove-VMHost $Ip -Confirm:$False
            $x = Read-Host "Press any key to continue ..."
        }
        10 {
            # VDS取得
            $Datacenter = Read-Host "Please enter Datacenter name"
            Clear-Host
            Get-Datacenter -Name $Datacenter | Get-VDSwitch
            $x = Read-Host "Press any key to continue ..."
        }
        11 {
            # VDS作成
            $Datacenter = Read-Host "Please enter Datacenter name"
            $VDSwitch = Read-Host "Please enter VDSwitch name"
            $NumUplinkPorts = Read-Host "Please enter NumUplinkPorts"
            Clear-Host
            Get-VMHostNetworkAdapter -VMHost $Datacenter
            New-VDSwitch -Name $VDSwitch -Location $myDatacenter -NumUplinkPorts $NumUplinkPorts
            $x = Read-Host "Press any key to continue ..."
        }
        12 {
            # VDS削除
            $VDSwitch = Read-Host "Please enter VDSwitch name"
            Clear-Host
            Get-VDSwitch -Name $VDSwitch | Remove-VDSwitch -Confirm:$False
            $x = Read-Host "Press any key to continue ..."
        }
        13 {
            # VMHost接続済VDS取得
            $Ip = Read-Host "Please enter VMHost name"
            Clear-Host
            Get-VMHost -Name $Ip | Get-VDSwitch
            $x = Read-Host "Press any key to continue ..."
        }
        14 {
            # VDSにVMHost追加
            $VDSwitch = Read-Host "Please enter VDSwitch name"
            $Ip = Read-Host "Please enter VMHost name"
            Clear-Host
            Get-VDSwitch -Name $VDSwitch | Add-VDSwitchVMHost -VMHost $Ip
            $x = Read-Host "Press any key to continue ..."
        }
        15 {
            # VDS接続済VMHost削除
            $VDSwitch = Read-Host "Please enter VDSwitch name"
            $Ip = Read-Host "Please enter VMHost name"
            Clear-Host
            Get-VDSwitch -Name $VDSwitch | Remove-VDSwitchVMHost -VMHost $Ip -Confirm:$False
            $x = Read-Host "Press any key to continue ..."
        }
        16 {
            # VDSアップリンクポート接続済物理アダプタ取得
            $Ip = Read-Host "Please enter VMHost name"
            Clear-Host
            Get-VMHostNetworkAdapter -VMHost $Ip | ft -autosize
            $x = Read-Host "Press any key to continue ..."
        }
        17 {
            # VDSアップリンクポートへ物理アダプタ追加
            $VDSwitch = Read-Host "Please enter VDSwitch name"
            $Ip = Read-Host "Please enter VMHost name"
            $Nic = Read-Host "Please enter VMHost NIC name"
            Clear-Host
            $vmhostNetworkAdapter = Get-VMHost $Ip | Get-VMHostNetworkAdapter -Physical -Name $Nic
            Get-VDSwitch $VDSwitch | Add-VDSwitchPhysicalNetworkAdapter -VMHostNetworkAdapter $vmhostNetworkAdapter
            $x = Read-Host "Press any key to continue ..."
        }
        18 {
            # VDSアップリンクポート接続済物理アダプタ削除
            $Ip = Read-Host "Please enter VMHost name"
            $Nic = Read-Host "Please enter VMHost NIC name"
            Clear-Host
            Get-VMhost -Name $Ip  | Get-VMHostNetworkAdapter -Physical -Name $Nic | Remove-VDSwitchPhysicalNetworkAdapter -Confirm:$False
            $x = Read-Host "Press any key to continue ..."
        }
        19 {
            # VDSアップリンクポート接続済物理アダプタ削除
            $VDSwitch = Read-Host "Please enter VDSwitch name"
            Clear-Host
            Get-VDPortGroup -VDSwitch $VDSwitch | fl
            $x = Read-Host "Press any key to continue ..."
        }
        20 {
            # ポートグループ作成
            $VDSwitch = Read-Host "Please enter VDSwitch name"
            $VDPortGroup = Read-Host "Please enter VDPortGroup name"
            Clear-Host
            Get-VDSwitch -Name $VDSwitch | New-VDPortgroup -Name $VDPortGroup
            $x = Read-Host "Press any key to continue ..."
        }
        21 {
            # ポートグループ削除
            $VDPortGroup = Read-Host "Please enter VDPortGroup name"
            Clear-Host
            Get-VDPortGroup -Name $VDPortGroup | Remove-VDPortGroup -Confirm:$False
            $x = Read-Host "Press any key to continue ..."
        }
        99 {
            # マニュアル 
            Clear-Host
            $Command = Read-Host "Please enter Command"
            $Command
            $x = Read-Host "Press any key to continue ..."
        }
        0 {
            # vCenter切断
            Clear-Host
            Write-Output 'Bye'
            Disconnect-VIServer -Server $Server -Force -Confirm:$False
            exit
        }
    default {break}
    }
}
