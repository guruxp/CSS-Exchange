﻿# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

. $PSScriptRoot\..\..\..\Shared\Confirm-ExchangeShell.ps1
function Invoke-ConfirmExchangeShell {

    $Script:ExchangeShellComputer = Confirm-ExchangeShell -CatchActionFunction ${Function:Invoke-CatchActions}

    if (-not ($Script:ExchangeShellComputer.ShellLoaded)) {
        Write-Warning "Failed to load Exchange Shell... stopping script"
        $Script:Logger.PreventLogCleanup = $true
        exit
    }

    if ($Script:ExchangeShellComputer.ToolsOnly -and
        $Script:ServerInstanceList.ToLower().Contains($env:COMPUTERNAME.ToLower()) -and
        -not ($LoadBalancingReport)) {
        Write-Warning "Can't run Exchange Health Checker Against a Tools Server. Use the -Server Parameter and provide the server you want to run the script against."
        $Script:Logger.PreventLogCleanup = $true
        exit
    }

    Write-Verbose("Script Executing on Server $env:COMPUTERNAME")
    Write-Verbose("ToolsOnly: $($Script:ExchangeShellComputer.ToolsOnly) | RemoteShell $($Script:ExchangeShellComputer.RemoteShell)")
}
