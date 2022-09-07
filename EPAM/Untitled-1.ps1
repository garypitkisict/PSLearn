$subscriptionid = "4683d4d4-04a9-4cad-91a2-fc9b67a0c737"
$prodlocation = "northcentralus"
$PRODSQL = "prd1srvr"
$UATSQL = "prd1srvr2"
$UATCONFIGDB = "UAT_Master_Config"
$PRODCONFIGDB = "PROD_Master_Config"
$sqladmincred = Get-Credential
set-azcontext -Subscription $subscriptionid
$dbrg = Get-AzResourceGroup  -name "PSTest" -Location $prodlocation
# $dbrg
$PRDsqlsrvr = New-AzSqlServer -ResourceGroupName $dbrg.ResourceGroupName -Location $prodlocation -ServerName $PRODSQL -ServerVersion "12.0" -SqlAdministratorCredentials $sqladmincred
$UATsqlsrvr = New-AzSqlServer -ResourceGroupName $dbrg.ResourceGroupName -Location $prodlocation -ServerName $UATSQL -ServerVersion "12.0" -SqlAdministratorCredentials $sqladmincred
$uatdb = New-AzSqlDatabase -ResourceGroupName $dbrg.ResourceGroupName -ServerName $UATsqlsrvr.ServerName -DatabaseName $UATCONFIGDB 
$prddb = New-AzSqlDatabase -ResourceGroupName $dbrg.ResourceGroupName -ServerName $PRDsqlsrvr.ServerName -DatabaseName $PRODCONFIGDB 

#########################
$createtable = "CREATE TABLE [dbo].[Organizations](
	[OrgID] [bigint] IDENTITY(1,1) NOT NULL,
	[OrgName] [varchar](50) NULL
)"

$params = @{
    'Database' = MyDatabase
    'ServerInstance' = $ServerInstance
    'Username' = 'UsernameHere'
    'Password' = 'PasswordHere'
    'Query' = 'SELECT * FROM Users'
}
Invoke-Sqlcmd @params

 stancesta