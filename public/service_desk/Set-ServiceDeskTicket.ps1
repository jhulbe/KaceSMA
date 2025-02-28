Function Set-ServiceDeskTicket {
    <#
    .DESCRIPTION
        Updates a ticket.
      
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER TicketID
        The ID of the ticket you want to update


    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE


        Set-SmaServiceDeskTicket -Server https://kace.example.com -Org Default -Credential (Get-Credential) -TicketID 1234 -Body $TicketUpdate

        Updates a ticket with ID 1234 with the information provided by the $body
        

    .NOTES
       
    #>
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'medium'
    )]
    param(
        [Parameter(Mandatory = $true,Position=0)]
        [string]
        $TicketID,

        [Parameter(Mandatory = $true)]
        [string]
        $Server,

        [Parameter()]
        [string]
        $Org = 'Default',

        [Parameter(Mandatory = $true)]
        [PSCredential]
        $Credential,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body
    )
    Begin {
        $Endpoint = "/api/service_desk/tickets/$TicketID"
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server,"PUT $Endpoint")) {
            New-ApiPUTRequest -Server $Server -Endpoint $Endpoint -Org $Org -Credential $Credential -Body $Body
        }
    }
    End {}
}