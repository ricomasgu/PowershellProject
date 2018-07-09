$string = $MyInvocation.InvocationName
$remove = $string.Split("\")
$path = $string.Replace($remove.Get($remove.Length-1),"")
echo $path"Hello"