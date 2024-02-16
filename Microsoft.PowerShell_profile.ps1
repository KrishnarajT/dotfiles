# path to Python virtual environment activation
$dsmlenv = "P:\Programs\DSML\DSMLEnv\Scripts\"
$expvenv = "P:\Programs\Python\Experimentation\ExpVenv\Scripts"

# ask the user if they wanna activate the DSML environment, exp environment, or none
$env = Read-Host "Activate 1. DSML environment, 2. Exp environment, or 3. None? (1/2/3)"

# depending on the $env, activate the corresponding environment
if ($env -eq "1") {
    cd $dsmlenv
    .\activate
    cd ..
    cd ..
} elseif ($env -eq "2") {
    cd $expvenv
    .\activate
    cd ..
    cd ..
} else {
    Write-Host "No environment activated"
}