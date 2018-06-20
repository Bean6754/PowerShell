# Interaction prompt.
if ( $(whoami)  -Contains 'root' )
{
        $MyUser = "#"
}
else
{
        $MyUser = "$"
}

function prompt {"$( gc Env:/PWD ): $( $MyUser ): "}

# Set foreground and background colours.
[console]::ForegroundColor = "Green"
$host.PrivateData.VerboseForegroundColor = "Green"
$host.UI.RawUI.ForegroundColor = "Green"

[console]::BackgroundColor = "black"
$host.PrivateData.VerboseBackgroundColor = "black"
$host.UI.RawUI.BackgroundColor = "black"

# Error message colouring.
$host.PrivateData.ErrorBackgroundColor = "DarkCyan"
$host.PrivateData.ErrorForegroundColor = "Yellow"
