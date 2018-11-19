-- read decrypted private key file
local f = io.open("private_key", "r")
local sign_priv = f:read()

local torchbear_bin = fs.read_file(os.getenv("PROJECT")) 
local priv_key = crypto.sign.load_secret(sign_priv)

-- generates signature
local signature = priv_key:sign_detached(torchbear_bin)

local sig_file_name = "torchbear-" .. os.getenv("TRAVIS_TAG") .."-".. os.getenv("ARCH") 
.."-".. os.getenv("PLATFORM") .."-".. os.getenv("CHANNEL")..".sig"

local file = io.open(sig_file_name, "w")
file:write(signature, "\n")
