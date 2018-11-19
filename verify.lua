-- load public key
local f = io.open("public_key", "r")
local pub_key_string = f:read()
local pub_key = crypto.sign.load_public(tostring(pub_key_string))


local filename = ""
local pfile = io.popen('ls "'.. "." ..'"')
for file in pfile:lines() do
     if file:match "%.sig$" then
	     filename = tostring(file)       
     end

end 
-- load signature
f = io.open(filename, "r")
local signature = tostring(f:read())


local torchbear_bin = fs.read_file("torchbear") 

local is_valid = pub_key:verify_detached(torchbear_bin, signature)

if is_valid then
	print("VERIFIED! The signature file is valid\n")
else
	print("The signature file is invalid\n")
end

os.exit()
