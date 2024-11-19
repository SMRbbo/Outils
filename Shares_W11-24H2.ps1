##########
##
##Nom : Shares_W11-24h2.ps1
##Description : modifiers les options de windows 11 24h2 pour pouvoir utiliser les dossiers partages DATA et MDT 
##Emplacement : cles usb boot isagri / cles expe / fichier historique (data/historique) 
##Date modification : 28/10/2024   
##Auteur : BBO
##
##########

#####Perplexcity
function Set-NetworkShareEdit {
    Write-Host "Aplication des modification de partage reseau..."

    #Disable SMB signing requirement:
    Set-SmbClientConfiguration -RequireSecuritySignature $false -Force

    #Enable insecure guest logons:
    Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Force
    
    Write-Host "Modifications effectuees."
}

function Remove-NetworkShareEdit {
    Write-Host "Application des paramètres par defaut..."

    #Disable SMB signing requirement:
    Set-SmbClientConfiguration -RequireSecuritySignature $true -Force

    #Enable insecure guest logons:
    Set-SmbClientConfiguration -EnableInsecureGuestLogons $false -Force
    
    Write-Host "Paramètres par defaut appliques."
}

#on vide l'affichage du terminal
clear

if(!(((Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').DisplayVersion) -gt "23h2")){
    Write-Host -ForegroundColor Red "Ce poste n'est pas en Windows 11 24H2 ou plus recent !`n Il n'est donc pas necessaire d'appliquer ces parametres!"
}

$choice = Read-Host -Prompt "
                            1) Retirer la securite des partages`n
                            2) Appliquer la securite par defaut`n
                            3) Exit`n
                            `n
                            Entrer le numero de votre choix "

switch ($choice) {
    1 { Set-NetworkShareEdit }
    2 { Remove-NetworkShareEdit }
    3 { break }
}