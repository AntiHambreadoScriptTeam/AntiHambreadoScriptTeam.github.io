
























local a=cloneref or(function(...)return...end)

local b=setmetatable({},{
__index=function(b,c)
rawset(b,c,a(game:GetService(c)))
return rawget(b,c)
end
})

local c=b.MarketplaceService
local d=b.UserInputService
local e=b.TweenService
local f=b.HttpService
local g=b.RunService
local h=b.Players

local i=g.Heartbeat

local j=h.LocalPlayer
local k=j:GetMouse()

local l=(gethui or function()return b.CoreGui end)()

local m={
Darker={
Colors={
Background=ColorSequence.new{
ColorSequenceKeypoint.new(0.00,Color3.fromRGB(25,25,25)),
ColorSequenceKeypoint.new(0.50,Color3.fromRGB(32.5,32.5,32.5)),
ColorSequenceKeypoint.new(1.00,Color3.fromRGB(25,25,25))
},
Primary=Color3.fromRGB(88,101,242),
OnPrimary=Color3.fromRGB(61,67,135),
ScrollBar=Color3.fromRGB(1,76,105),
Stroke=Color3.fromRGB(45,45,45),

Error=Color3.fromRGB(255,102,102),
Icons=Color3.fromRGB(232,233,235),

JoinButton=Color3.fromRGB(37,128,69),
Link=Color3.fromRGB(40,150,255),

Dialog={
Background=Color3.fromRGB(28,28,28)
},
Buttons={
Holding=Color3.fromRGB(32,32,32),
Default=Color3.fromRGB(28,28,30)
},
Border={
Holding=Color3.fromRGB(60,60,60),
Default=Color3.fromRGB(38,38,38),
},
Text={
Default=Color3.fromRGB(255,255,255),
Dark=Color3.fromRGB(200,200,200),
Darker=Color3.fromRGB(175,175,175),
},
Slider={
SliderBar=Color3.fromRGB(1,76,105),
SliderNumber=Color3.fromRGB(232,233,235),
},
Dropdown={
Holder=Color3.fromRGB(30,30,30),
}
},
Icons={
Error="rbxassetid://10709752996",
Button="rbxassetid://10709791437",
Close="rbxassetid://10747384394",
TextBox="rbxassetid://15637081879",
Search="rbxassetid://10734943674",
Keybind="rbxassetid://10734982144",
Dropdown={
Open="rbxassetid://10709791523",
Close="rbxassetid://10709790948"
}
},
Font={
Normal=Enum.Font.BuilderSans,
Medium=Enum.Font.BuilderSansMedium,
Bold=Enum.Font.BuilderSansBold,
ExtraBold=Enum.Font.BuilderSansExtraBold,
SliderValue=Enum.Font.FredokaOne
},
BackgroundTransparency=0.03
}
}

for n,o in m do
o.Name=n
table.freeze(o)
end

local n={
Information={
Version="v2.0.1",
GitHubOwner="tlredz"
},
Default={
Theme="Darker",
UISize=UDim2.fromOffset(550,380),
TabSize=160
},

Themes=m,

Connections={},
Options={},
Tabs={}
}

n.Info=n.Information
n.Save=n.Default

local o=workspace.CurrentCamera.ViewportSize local p=function(

p, q, r)
table.insert(n.Connections,p[r or"Connect"](p,q))end


local q={}
q.__index=q local r=function(

r, s)
for t in s:gmatch"[^%.]+"do
r=r[t]
end

return r end local s=function(


s, t, u, v)
if not v then
v=n.CurrentTheme
end

s[t]=r(v,if type(u)=="function"then u()else u)end local t=function(


t, u, v)
for w,x in v do
s(u,w,x,t)
end end local u=function(


u, v)
if makefolder then
local w=u:split"/"
w[#w]=nil

local x=table.concat(w,"/")

if x~=""and(isfolder==nil or not isfolder(x))then
makefolder(x)
end
end

writefile(u,v)end


local v=false

local w={
MAX_SCALE=1.6,
MIN_SCALE=0.6,

TEXTBOX={
PLACEHOLDER_TEXT="Input"
}
}

function q:add(x,y)
self.Descendants[y]=x

if self.IS_RENDERING then
t(n.CurrentTheme,x,y)
end
end

function q:update()
if self.IS_RENDERING and not self.UPDATED_OBJECTS then
local x=n.CurrentTheme
self.UPDATED_OBJECTS=true

for y,z in self.Descendants do
local A=typeof(z)
if A=="table"then z:update()continue end

t(x,z,y)
end
end
end

function q:destroy()
local x=self.Parent and table.find(self.Parent.Descendants)

if x then
table.remove(self.Parent.Descendants,x)
end

table.clear(self.Descendants)
setmetatable(self,nil)
end

function q:changeRendering(x)
if self.IS_RENDERING~=x then
self.IS_RENDERING=x
self.UPDATED_OBJECTS=false
end
end

function q:new()
local x=setmetatable({
IS_RENDERING=true,
UPDATED_OBJECTS=false,
Descendants={},
Parent=self.Descendants~=nil and self or nil
},q)

if self.Descendants then
table.insert(self.Descendants,x)
end

return x
end

local x=q:new()

local y,z={}do
local A={}

local B={}do
B.ElementsTable={
Corner=function(C)
return z("UICorner",{
CornerRadius=C or UDim.new(0,8)
})
end,
Stroke=function(C,D)
return z("UIStroke",{
Color=C or Color3.fromRGB(60,60,60),
Thickness=D or 1
})
end,
Image=function(C)
return z("ImageLabel",{
Image=C or"",
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1)
})
end,
Button=function()
return z("TextButton",{
Text="",
Size=UDim2.fromScale(1,1),
AutoButtonColor=false
})
end,
Padding=function(C,D,E,F)
return z("UIPadding",{
PaddingLeft=C or UDim.new(0,10),
PaddingRight=D or UDim.new(0,10),
PaddingTop=E or UDim.new(0,10),
PaddingBottom=F or UDim.new(0,10)
})
end,
ListLayout=function(C)
return z("UIListLayout",{
Padding=C or UDim.new(0,5)
})
end,
Text=function(C)
return z("TextLabel",{
BackgroundTransparency=1,
Text=C or""
})
end,
Gradient=function(C)
return z("UIGradient",{
Color=C
})
end
}

function B:Create(C,D,...)
local E=self.ElementsTable[D]

if E then
local F=E(...)
F.Parent=C
return F
end
end
end

local C={}

function C:Childs(D)
for E=1,#D do
D[E].Parent=self
end
end

function C:Elements(D)
for E,F in pairs(D)do
if type(F)=="table"then
y.SetProperties(B:Create(self,E),F)
else
B:Create(self,E,F)
end
end
end

function C:ThemeTag(D)
local E=D.OBJECTS
D.OBJECTS=nil
return(E or x):add(self,D)
end

function y:SetProperties(D)
for E,F in pairs(D)do
if C[E]then
C[E](self,F)
else
self[E]=F
end
end
end

function y:SetValues(...)
local D=self

for E,F in{...}do
local G=typeof(F)

if G=="table"then
y.SetProperties(D,F)
else
D[if G=="string"then"Name"else"Parent"]=F
end
end

return D
end

local D

function y:Draggable(E,F,G)
local H,I,J,K
local L=F or 0.28
local M=0
local N local O=function(

O)
local P=O.Position-I
local Q
M=tick()

if G then
Q=G(
J.X.Scale,J.X.Offset+P.X/E.Scale,
J.Y.Scale,J.Y.Offset+P.Y/E.Scale
)
else
Q=UDim2.new(
J.X.Scale,J.X.Offset+P.X/E.Scale,
J.Y.Scale,J.Y.Offset+P.Y/E.Scale
)
end
self.Position=self.Position:Lerp(Q,L)end local P=function()



while D==self do
if(tick()-M)>=1 then
N()
break
end
task.wait()
end end


local Q={
[Enum.UserInputType.MouseButton1]=true,
[Enum.UserInputType.Touch]=true
}

local R={
[Enum.UserInputType.MouseMovement]=true,
[Enum.UserInputType.Touch]=true
}

p(self.InputBegan,function(S)
if v==false and D==nil and Q[S.UserInputType]then
I=S.Position
J=self.Position
D=self
M=tick()
v=true

local T;

function N()
v=false
D=nil
T:Disconnect()
end

task.spawn(P)

T=S.Changed:Connect(function()
if S.UserInputState==Enum.UserInputState.End then
N()
end
end)
end
end)

p(d.InputChanged,function(S)
if D==self and R[S.UserInputType]then
O(S)
end
end)
end

function y:CreateNewTemplate(E)
return y.CloneObject(A[self],E)
end

function y.new(E,...)
return y.SetValues(Instance.new(E),...)
end

z=y.new
end

local A={}local B=function(

B)
if B==nil then
return{}
end

if type(B)~="function"and type(B)~="table"then
error(`Failed to get Callback: 'function', or 'table' expected, got {typeof(B)}`,2)
end

if type(B)~="function"then
local C=B[1]
local D=B[2]

B=function(E)
C[D]=E
end
end

return table.pack(B)end local C=function(


C)
A[C]=nil end local D=function(


D, ...)
if A[D]then return end

A[D]=true

for E=1,#D do
task.spawn(D[E],...)
end

task.defer(C,D)end


local E="redz-library-v5"
local F=l:FindFirstChild(E)

if not F then
F=z("ScreenGui",E,l,{
IgnoreGuiInset=true
})
end local G=function(

G, H, I, J, ...)
local K=TweenInfo.new(J,EasingStyle or Enum.EasingStyle.Quint,...)

return e:Create(G,K,{
[H]=I
})end local H=function(


H)
local I={}
for J=1,#H do
rawset(I,H[J],true)
end
return I end


local I=H(string.split"\n\t,_:;()[]#&=!. \"'*^<>$")local J=function(

J)
return string.gsub(J:lower(),".",function(K)
return I[K]and""or K
end)end local K=function(


K)
local L,M,N=tostring(K),"",0

for O=#L,1,-1 do
M=L:sub(O,O)..M
N+=1

if O>1 and N%3==0 then
M=","..M
end
end

return M end local L=function(


L)
local M="rbxassetid://"
return L:sub(1,#M)==M end local M=function(


M)
return(o.Y/450)*M end local N=function(


N)
local O=math.floor(N/60)
local P=math.floor(N/60/60)
N=math.floor((N-(O*60))*10)/10
O=O-(P*60)

if P>0 then
return`{P}h {O}m {math.floor(N)}s`
elseif O>0 then
return`{O}m {math.floor(N)}s`
else
return tostring(N)
end end


local O={}do
local P={}
local Q={}
local R={}
local S={}

local T
local U
local V
local W
local X
local Y
local Z
local _
local aa

local ab=""

local ac={SelectedTab=1,Minimized=false}
ac.__index=ac

local ad={}
ad.__index=ad

local ae={}
ae.__index=ae

local af={}
af.__index=af

local ag={}do local ah=function()

local ah={}
ah.__index=function(ai,aj)
return ah[aj]or rawget(ae,aj)
end

return ah end


local ai=ah()
ag.TextBox=ai

local aj=ah()
ag.Toggle=aj

local ak=ah()
ag.Slider=ak

local al=ah()
ag.Dropdown=al

local am=ah()
ag.Keybind=am

local an=ah()
ag.Dialog=an local ao=function()


W.Closed=true
W.Closing=false
setmetatable(W,nil)

W=nil
X.Parent=nil end local ap=function()



if W~=nil then
W:Close()
end end


function an:NewOption(aq)
local ar=aq[1]or aq.Name or aq.Title
local as=B(aq[2]or aq.Callback)

table.insert(as,ap)

assert(type(ar)=="string",`"Dialog.NewOption.Name". 'string' expected, got {typeof(ar)}`)

local at=z("TextButton",{
AutoButtonColor=false,
Size=UDim2.fromScale(0.2,1),
BackgroundTransparency=1,
TextSize=10,
Text=ar,
Elements={
Corner=UDim.new(1,0)
},
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
TextColor3="Colors.Text.Dark",
Font="Font.Normal"
}
})

local au=G(at,"BackgroundTransparency",0,0.3)
local av=G(at,"BackgroundTransparency",1,0.3)

p(at.MouseLeave,function()av:Play()end)
p(at.MouseEnter,function()au:Play()end)
p(at.Activated,function()D(as)end)

at.Parent=X.Template.Options
end

function an:Close(aq)
if self.Closed or self.Closing or W~=self then
return nil
end

self.Closing=true

local ar=G(self.TEMPLATE,"Size",self.NEW_SIZE,0.1)
ar:Play()

if aq then
ar.Completed:Wait()
ao()
else
p(ar.Completed,ao)
end
end

function an.new(aq,ar)
return setmetatable({
TITLE_LABEL=aq,
DESCRIPTION_LABEL=aq,
Content=aq.Text,
Title=ar.Text,

Closed=false,
Closing=false,
Kind="Dialog"
},an)
end

function al:SetEnabled(aq)
assert(type(aq)=="table",`"Dropdown.SetEnabled[param 1]". 'table' expected, got {typeof(aq)}`)

self.SET_ENABLED_OPTIONS(aq)
end

function al:Clear()
self.CLEAR_DROPDOWN()
end

function al:NewOptions(...)
self:Clear()
self:Add(...)
end

function al:GetOptionsCount()
return#self.DROPDOWN_OPTIONS
end

function al:Remove(...)
local aq={...}
assert(#aq>0,"'Dropdown.Remove' requires one or more options.")

for ar,as in aq do
self.REMOVE_DROPDOWN_OPTION(as)
end
end

function al:Add(...)
local aq={...}
assert(#aq>0,"'Dropdown.Add' requires one or more options.")

for ar,as in aq do
self.ADD_DROPDOWN_OPTION(as)
end
end

function al.new(aq,ar,as,at,au)
return setmetatable({
CALLBACKS=au,

DESTROY_ELEMENT=ar,
VISIBLE_ELEMENT=ar,

TITLE_LABEL=as,
DESCRIPTION_LABEL=at,
Description=at.Text,
Title=as.Text,

Parent=aq,
Kind="Dropdown"
},al)
end

function ak:SetValue(aq)
assert(type(aq)=="number",`"Slider.SetValue". 'number' expected, got {typeof(aq)}`)

if self.Value~=aq then
self.WHEN_VALUE_CHANGED(aq)
end
end

function ak.new(aq,ar,as,at,au)
return setmetatable({
CALLBACKS=au,

DESTROY_ELEMENT=ar,
VISIBLE_ELEMENT=ar,

TITLE_LABEL=as,
DESCRIPTION_LABEL=at,
Description=at.Text,
Title=as.Text,

Parent=aq,
Kind="Slider"
},ak)
end

function aj:SetValue(aq)
assert(type(aq)=="boolean",`"Toggle.SetValue". 'boolean' expected, got {typeof(aq)}`)

if self.Value~=aq then
self.Value=aq
self.WHEN_VALUE_CHANGED(aq)
end
end

function aj.new(aq,ar,as,at,au,av)
return setmetatable({
CALLBACKS=av,
WHEN_VALUE_CHANGED=au,

DESTROY_ELEMENT=ar,
VISIBLE_ELEMENT=ar,

TITLE_LABEL=as,
DESCRIPTION_LABEL=at,
Description=at.Text,
Title=as.Text,

Parent=aq,
Kind="Toggle"
},aj)
end

function ai:SetText(aq)
assert(type(aq)=="string",`"TextBox.SetText". 'string' expected, got {typeof(aq)}`)

self.TEXTBOX.Text=aq
return self
end

function ai:SetPlaceholder(aq)
assert(type(aq)=="string",`"TextBox.SetPlaceholder". 'string' expected, got {typeof(aq)}`)

self.TEXTBOX.PlaceholderText=aq
return self
end

function ai:CaptureFocus()
self.TEXTBOX:CaptureFocus()
return self
end

function ai:Clear()
self.TEXTBOX.Text=""
return self
end

function ai:SetTextFilter(aq)
if aq~=nil then
assert(type(aq)=="function",`"TextBox.SetTextFilter[param 1]". 'function', or 'nil' expected, got {typeof(aq)}`)
end

self.TEXTBOX_TEXT_FILTER=aq
return self
end

function ai.new(aq,ar,as,at,au,av)
return setmetatable({
Title=ar.Text,
Description=as.Text,
DESCRIPTION_LABEL=as,
TITLE_LABEL=ar,

CALLBACKS=av,
DESTROY_ELEMENT=at,
VISIBLE_ELEMENT=at,

TEXTBOX=au,
BUTTON=at,

Parent=aq,
Kind="TextBox"
},ai)
end

ai.Set=ai.SetText
aj.Set=aj.SetValue
ak.Set=ak.SetValue
end local ah=function(

ah, ai, aj)
local ak=z("TextButton","Button",aj,{
Size=UDim2.new(1,0,0,24),
AutoButtonColor=false,
Text="",
Elements={
Corner=UDim.new(0,6)
},
ThemeTag={
BackgroundColor3="Colors.Buttons.Default"
},
Childs={
z("TextLabel","Title",{
BackgroundTransparency=1,
Font=Enum.Font.GothamMedium,
Text=ai.Title,
TextSize=10,
TextXAlignment=Enum.TextXAlignment.Left,
TextTransparency=(FirstTab and 0.3)or 0,
TextTruncate=Enum.TextTruncate.AtEnd,
ThemeTag={
TextColor3="Colors.Text.Default"
}
})
}
})

local al=z("Frame",ak,{
Position=UDim2.new(0,1,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
Size=UDim2.fromOffset(4,4),
BackgroundTransparency=1,
ThemeTag={
BackgroundColor3="Colors.Primary"
},
Elements={
Corner=UDim.new(0.5,0)
}
})

local am=z("ScrollingFrame","Container",{
Size=UDim2.new(1,0,1,0),
Position=UDim2.new(0,0,1),
AnchorPoint=Vector2.new(0,1),
ScrollBarThickness=1.5,
BackgroundTransparency=1,
ScrollBarImageTransparency=0.2,
AutomaticCanvasSize=Enum.AutomaticSize.Y,
ScrollingDirection=Enum.ScrollingDirection.Y,
BorderSizePixel=0,
CanvasSize=UDim2.new(),
ThemeTag={
ScrollBarImageColor3="Colors.ScrollBar"
},
Elements={
Padding={
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
PaddingTop=UDim.new(0,10),
PaddingBottom=UDim.new(0,10)
},
ListLayout={
Padding=UDim.new(0,5)
}
}
})

local an=z("ImageLabel",ak,{
Position=UDim2.new(0,8,0.5),
Size=UDim2.new(0,13,0,13),
AnchorPoint=Vector2.new(0,0.5),
BackgroundTransparency=1,
ImageTransparency=0.3,
Image=ai.Icon or""
})local ao=function()


local ao=string.sub(an.Image,1,13)=="rbxassetid://"
local ap=ak.Title
an.Visible=ao
ap.Size=UDim2.new(1,ao and-25 or-15,1)
ap.Position=UDim2.fromOffset(ao and 25 or 15)end


p(an:GetPropertyChangedSignal"Image",ao)
ao()

return ak,am,al,an end local ai=function(


ai, aj, ak, al)
local am=z("TextLabel",{
TextXAlignment=Enum.TextXAlignment.Left,
TextTruncate=Enum.TextTruncate.AtEnd,
AutomaticSize=Enum.AutomaticSize.Y,
Size=UDim2.new(1,-20),
Position=UDim2.fromScale(0,0.5),
AnchorPoint=Vector2.new(0,0.5),
BackgroundTransparency=1,
TextSize=11,
ThemeTag={
OBJECTS=x,
TextColor3="Colors.Text.Default",
Font="Font.Medium"
}
})

local an=S[ai]
local ao=Q[ai].Container

local ap=z("TextLabel",{
TextXAlignment=Enum.TextXAlignment.Left,
AutomaticSize=Enum.AutomaticSize.Y,
Size=UDim2.new(1,-20),
Position=UDim2.new(0,12,0,15),
BackgroundTransparency=1,
TextWrapped=true,
TextSize=8,
RichText=true,
ThemeTag={
OBJECTS=an,
TextColor3="Colors.Text.Dark",
Font="Font.Normal"
}
})

local aq=z("TextButton","Option",{
AutomaticSize=Enum.AutomaticSize.Y,
Size=UDim2.new(1,0,0,25),
Text="",
ThemeTag={
OBJECTS=an,
BackgroundColor3="Colors.Buttons.Default"
},
Elements={
Corner=UDim.new(0,6)
},
Childs={
z("Frame","Holder",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=al,
Elements={
ListLayout={
SortOrder=Enum.SortOrder.LayoutOrder,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,2)
},
Padding={
PaddingBottom=UDim.new(0,5),
PaddingTop=UDim.new(0,5)
}
},
Childs={am,ap}
})
}
})

local ar=aq.Holder

p(ap:GetPropertyChangedSignal"Text",function()
local as=#ap.Text>0

if ap.Visible~=as then
local at=as and 0 or 0.5
ap.Visible=as
ar.Position=UDim2.fromScale(0,at)
ar.AnchorPoint=Vector2.new(0,at)
end
end)

am.Text=aj
ap.Text=ak or""

aq.Parent=ao

return aq,am,ap end local aj=function(


aj, ak)
if type(ak)~="table"then
error(`"Tab.Add{aj}[Configs]". 'table' expected, got {typeof(ak)}`,2)
end

local al=ak[1]or ak.Name or ak.Title
local am=ak.Desc or ak.Description

assert(type(al)=="string",`"Tab.Add{aj}.Title". 'string' expected, got {typeof(al)}`)

if am~=nil and type(am)~="string"then
error(`"Tab.Add{aj}.Description". 'string', or 'nil' expected, got {typeof(am)}`,2)
end

return al,am or""end local ak=function(


ak, al)
if al~=nil and type(al)~="string"then
error(`"Tab.Add{ak}.Flag". 'nil', or 'string' expected, got {typeof(al)}`)
end

return al end local al=function()



local al=160

local am={
Corner=UDim.new(0,6),
Stroke={
ThemeTag={
Color="Colors.Stroke"
}
},
Gradient={
Rotation=45,
ThemeTag={
Color="Colors.Background"
}
}
}

local an=z("TextButton",OutBox,{
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
Active=true,
Text=""
})

local ao=z("Frame","Dropdown",an,{
Size=UDim2.fromOffset(al,100),
Position=UDim2.fromOffset(50,50),
Elements=am,
Active=true,
ThemeTag={
BackgroundTransparency="BackgroundTransparency"
}
})

local ap=z("TextButton","Search",ao,{
Position=UDim2.new(1,5,0,5),
Size=UDim2.new(0,25,0,25),
AutomaticSize=Enum.AutomaticSize.X,
Active=true,
Elements=am,
Text="",
ThemeTag={
BackgroundTransparency="BackgroundTransparency"
},
Childs={
z("UIPadding",{
PaddingLeft=UDim.new(0,5),
PaddingRight=UDim.new(0,5),
PaddingBottom=UDim.new(0,5),
PaddingTop=UDim.new(0,5)
}),
z("UIListLayout",{
Padding=UDim.new(0,5),
FillDirection=Enum.FillDirection.Horizontal
}),
z("TextBox","SearchBox",{
Size=UDim2.fromScale(0,1),
Position=UDim2.fromScale(0.5,0.5),
AnchorPoint=Vector2.new(0.5,0.5),
Visible=false,
PlaceholderText="Search...",
ClearTextOnFocus=false,
Text="",
Elements={
Corner=UDim.new(0,6)
},
ThemeTag={
BackgroundColor3="Colors.Stroke",
TextColor3="Colors.Text.Default",
Font="Font.ExtraBold"
}
}),
z("ImageLabel","SearchIcon",{
Size=UDim2.fromScale(1,1),
SizeConstraint=Enum.SizeConstraint.RelativeYY,
Position=UDim2.fromScale(0.5,0.5),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=1,
ThemeTag={
BackgroundColor3="Colors.Stroke",
ImageColor3="Colors.Icons",
Image="Icons.Search"
}
})
}
})

local aq=z("ScrollingFrame",ao,{
Size=UDim2.new(1,-6,1,-6),
Position=UDim2.fromScale(0.5,0.5),
AnchorPoint=Vector2.new(0.5,0.5),
ScrollBarThickness=3,
BackgroundTransparency=1,
BorderSizePixel=0,
CanvasSize=UDim2.new(),
ScrollingDirection=Enum.ScrollingDirection.Y,
AutomaticCanvasSize=Enum.AutomaticSize.Y,
Active=true,
ThemeTag={
OBJECTS=x,
ScrollBarImageColor3="Colors.ScrollBar"
},
Elements={
Padding={
PaddingLeft=UDim.new(0,8),
PaddingRight=UDim.new(0,8),
PaddingTop=UDim.new(0,5),
PaddingBottom=UDim.new(0,5)
},
ListLayout={
Padding=UDim.new(0,4)
}
}
})

local ar=ap.SearchIcon
local as=ap.SearchBox

local at=130

local au=G(ao,"Size",UDim2.fromOffset(al,0),0.2)
local av=G(as,"Size",UDim2.new(0,at-30,1,0),0.3)
local aw=G(as,"Size",UDim2.new(0,0,1,0),0.2)

local ax={}
local ay=false
local az=false
local aA
local aB
local aC
local aD
local aE

local aF=0

local aG=25
local aH=(aG*12)+10
local aI=5 local aJ=function(

aJ)
local aK=F.AbsoluteSize.Y/_.Scale
return math.min((aG*math.max(aJ,0.5))+10,aH,aK/1.75)end local aK=function()



local aK=ao.AbsolutePosition
local aL=ao.AbsoluteSize

local aM=Vector2.new(k.X,k.Y)

local aN=aM.X>=aK.X and aM.X<=(aK.X+aL.X)
local aO=aM.Y>=aK.Y and aM.Y<=(aK.Y+aL.Y)

return aN and aO end local aL=function(


aL, aM)
local aN=aE.AbsolutePosition
local aO=aE.AbsoluteSize
local aP=F.AbsoluteSize
local aQ=_.Scale
local aR=aJ(aL)

local aS=aP.X/aQ
local aT=aP.Y/aQ
local aU=aN.X/aQ
local aV=aN.Y/aQ
local aW=aO.X/aQ
local aX=aO.Y/aQ

local aY=aV+(aX/2)
local aZ=aY-(aR/2)

local a_=aI
local a0=aT-aR-aI

local a1=math.clamp(aZ,a_,a0)

local a2=Vector2.new(0,0)

if a1>(aT*0.7)then
a2=Vector2.new(0,1)
a1=math.min(aY+(aR/2),aT-aI)
end

local a3=math.clamp(
aU,
aI,
aS-ao.Size.X.Offset-(aI*2)-(ap.AbsoluteSize.X/aQ)
)

return Vector2.new(a3,a1),a2 end local aM=function(...)



local aM,aN=aL(...)

ao.AnchorPoint=aN
ao.Position=UDim2.fromOffset(aM.X,aM.Y)end local aN=function()



if not az then return end

az=false

as.Text=""
aw:Play()
aw.Completed:Wait()
as.Visible=false end local aO=function()



if az then return end

az=true

as.Visible=true
av:Play()

as:CaptureFocus()

local aO=ao.AbsoluteSize
local aP=F.AbsoluteSize
local aQ=_.Scale
local aR=ao.AnchorPoint

local aS=at*aQ

local aT=ao.AbsolutePosition.X

local aU=aT+aO.X+5+aS

if aU>aP.X-(aI*aQ)then
local aV=(aP.X-aO.X-aS-5-(aI*aQ))/aQ

aV=math.max(aV,aI)

G(ao,"Position",UDim2.fromOffset(aV,ao.Position.Y.Offset),0.3):Play()
end end local aP=function(


aP)
if not ay then
aA=aP
an.Parent=V
return true
end end local aQ=function()



if ay then return end

if aA then
aA()
aA=nil
end

task.spawn(aN)
ay=true
au:Play()
au.Completed:Wait()
an.Parent=nil
ay=false end local aR=function()



if as:IsFocused()then
aF=tick()
return nil
end

if(tick()-aF)>=0.3 and not aK()then
aQ()
end end local aS=function()



for aS,aT in ax do
aS.Parent=nil
ax[aS]=nil
end end local aT=function(


aT, aU)
aT.Selected=aU

if aT.Instance then
local aV=aT.Instance
local aW=aV.TextLabel
local aX=aV.Frame

local aY=aU and 0 or(aD and 0.8 or 1)
local aZ=aU and 0 or 0.4
local a_=UDim2.fromOffset(4,aU and 14 or 4)

if aV.Parent then
G(aX,"BackgroundTransparency",aY,0.35):Play()
G(aW,"TextTransparency",aZ,0.35):Play()
G(aX,"Size",a_,0.35):Play()
else
aW.TextTransparency=aZ
aX.BackgroundTransparency=aY
aX.Size=a_
end
end end local aU=function(


aU)
if as.Visible==false or not aU then
local aV=aC and#aC or 0
ao.Size=UDim2.fromOffset(al,aJ(aV))
return nil
end

if aU then
local aV=aU.Instance
local aW=J(as.Text)
aV.Visible=#aW==0 or aU.SearchText:find(aW)~=nil

if aV.Visible~=false then
SEARCH_RESULT_COUNT+=1
ao.Size=UDim2.fromOffset(al,aJ(SEARCH_RESULT_COUNT))
end
end end local aV=function(


aV, aW, aX, aY)
local aZ=true

if aW=="+"or aW=="-"then
aZ=aV.Selected==(aW=="+")
aX=aX:sub(2,-1)
end

return aZ and aY:find(aX,1,true)~=nil end local aW=function(


aW, aX)
local aY=z("TextButton",{
Size=UDim2.new(1,0,0,21),
AutoButtonColor=false,
Text="",
Elements={
Corner=UDim.new(0,4)
},
ThemeTag={
BackgroundColor3="Colors.Buttons.Default"
},
Childs={
z("Frame",{
Position=UDim2.new(0,1,0.5),
Size=UDim2.new(0,4,0,4),
BackgroundTransparency=1,
AnchorPoint=Vector2.new(0,0.5),
Elements={
Corner=UDim.new(0.5,0)
},
ThemeTag={
BackgroundColor3="Colors.Primary"
}
}),
z("TextLabel",{
Size=UDim2.fromScale(1,1),
Position=UDim2.fromOffset(10,0),
TextXAlignment=Enum.TextXAlignment.Left,
BackgroundTransparency=1,
TextTransparency=0.4,
Text=aW.DisplayName,
TextSize=9,
ThemeTag={
Font="Font.Bold",
TextColor3="Colors.Text.Default"
}
})
}
})

local aZ=0

p(aY.Activated,function()
if(tick()-aZ)<0 then return end

aZ=tick()+0.2
aB(aW)
end)

aW.SearchText=J(aW.DisplayName)
aW.Instance=aY

if aX then
local a_=as.Text

if#a_>0 then
local a0=string.sub(a_,1,1)
local a1=J(as.Text)
aY.Visible=aV(aW,a0,a1,aW.SearchText)
end

aY.Parent=aq
aU(aW)
end

aT(aW,aW.Selected)end local aX=function(


aX)
aS()
aC=aX

for aY=1,#aX do
local aZ=aX[aY]
local a_=aZ.Instance

if a_==nil then
aW(aZ)
a_=aZ.Instance
end

a_.Parent=aq
ax[a_]=true
end

aM(#aX)
G(ao,"Size",UDim2.fromOffset(al,aJ(#aX)),0.3):Play()end local aY=function()



local aY=as.Text
local aZ=string.sub(aY,1,1)
local a_=J(aY)
local a0=#a_==0
local a1=0

for a2=1,#aC do
local a3=aC[a2]
local a4=a0 or aV(a3,aZ,a_,a3.SearchText)
a3.Instance.Visible=a4

if a4 then
a1+=1
end
end

SEARCH_RESULT_COUNT=a1
ao.Size=UDim2.fromOffset(al,aJ(a1))end


p(Y:GetPropertyChangedSignal"Visible",aR)
p(Y:GetPropertyChangedSignal"Size",aR)
p(an.MouseButton1Down,aR)
p(an.Activated,aR)

p(ap.Activated,aO)
p(as:GetPropertyChangedSignal"Text",aY)

return table.freeze{
CreateOptionTemplate=aW,
SetOptionValue=aT,
CloseDropdown=aQ,
OpenDropdown=aP,
SetOptions=aX,
Clear=aS,
SetOnClicked=function(...)
aB=...
end,
SetMultiSelect=function(...)
aD=...
end,
SetHolder=function(...)
aE=...
end
}end


local am

local an={"W","A","S","D","Tab","Slash","Backspace","Escape","Unknown"}
local ao={"MouseButton1","MouseButton2","MouseButton3"}

local ap=H({"number","string","nil","boolean","table"},true)local aq=function(

aq)
if am==nil then
am=H(Enum.KeyCode:GetEnumItems())
end

return typeof(aq)=="EnumItem"and am[aq]end


function ad:GetNoSelfCall(ar)
assert(type(ar)=="string",`"Tab.GetNoSelfCall". 'string' expected, got {typeof(ar)}`)
local as=self[ar]
assert(type(as)=="function",`"Tab.GetNoSelfCall". '{as}' is not a 'function'-{ar}`)

return function(...)
return as(self,...)
end
end

function ad:AddSection(ar)
assert(ar==nil or type(ar)=="string",`"Tab.AddSection[param 1]". 'string', or 'nil' expected, got {typeof(ar)}`)
ar=ar or""

local as=S[self]

local at=z("Frame","Option",Q[self].Container,{
Size=UDim2.new(1,0,0,20),
BackgroundTransparency=1
})

local au=z("TextLabel",at,{
TextXAlignment=Enum.TextXAlignment.Left,
TextTruncate=Enum.TextTruncate.AtEnd,
Size=UDim2.new(1,-25,1,0),
Position=UDim2.new(0,5),
BackgroundTransparency=1,
TextSize=17,
Text=ar,
ThemeTag={
OBJECTS=as,
TextColor3="Colors.Text.Default",
Font="Font.Bold"
}
})

return setmetatable({
Title=ar,

DESTROY_ELEMENT=at,
VISIBLE_ELEMENT=at,
TITLE_LABEL=au,

Kind="Section",
Parent=self
},ae)
end

function ad:AddToggle(ar)
local as,at=aj("Toggle",ar)
local au=ak("Toggle",ar[4]or ar.Flag)

local av=ar[2]or ar.Default or false
local aw=B(ar[3]or ar.Callback)

if type(av)~="boolean"then
error(`"Tab.AddToggle.Default". 'boolean' expected, got {typeof(av)}`,2)
end

if au~=nil and type(aa[au])=="number"then
av=aa[au]==0
end

local ax=S[self]
local ay,az,aA=ai(self,as,at,UDim2.new(1,-38,0,0))

local aB=z("Frame",ay,{
Size=UDim2.new(0,35,0,18),
Position=UDim2.new(1,-10,0.5),
AnchorPoint=Vector2.new(1,0.5),
Elements={
Corner=UDim.new(0.5,0)
},
ThemeTag={
OBJECTS=ax,
BackgroundColor3="Colors.Stroke"
}
})

local aC=z("Frame",aB,{
BackgroundTransparency=1,
Size=UDim2.new(0.8,0,0.8,0),
Position=UDim2.new(0.5,0,0.5,0),
AnchorPoint=Vector2.new(0.5,0.5)
})

local aD={
OBJECTS=ax,
BackgroundColor3="Colors.OnPrimary"
}

local aE=z("Frame",aC,{
Size=UDim2.new(0,12,0,12),
Position=UDim2.new(0,0,0.5),
AnchorPoint=Vector2.new(0,0.5),
Elements={
Corner=UDim.new(0.5,0)
},
ThemeTag=aD
})local aF=function(

aF)
if au~=nil then aa[au]=aF and 0 or 1 end
D(aw,aF)

local aG=UDim2.new(aF and 1 or 0,0,0.5,0)
local aH=Vector2.new(aF and 1 or 0,0.5)
local aI=aF and"Colors.Primary"or"Colors.OnPrimary"
local aJ=r(n.CurrentTheme,aI)

aD.BackgroundColor3=aI

if self.Selected then
G(aE,"Position",aG,0.25):Play()
G(aE,"AnchorPoint",aH,0.25):Play()
G(aE,"BackgroundColor3",aJ,0.25):Play()
else
aE.Position=aG
aE.AnchorPoint=aH
aE.BackgroundColor3=aJ
end end


local aG=ag.Toggle.new(self,ay,az,aA,aF,aw)

aG.Value=av

task.defer(aF,av)

local aH=0

p(ay.Activated,function()
if(tick()-aH)<0 then return end

aH=tick()+0.2
aG:SetValue(not aG.Value)
end)

return aG
end

function ad:AddButton(ar)
local as,at=aj("Button",ar)
local au=B(ar[2]or ar.Callback)
local av=ar.Debounce or ar.Cooldown

local aw=S[self]
local ax,ay,az=ai(self,as,at,UDim2.new(1,-20,0,0))

local aA=z("ImageLabel",ax,{
Size=UDim2.new(0,14,0,14),
Position=UDim2.new(1,-10,0.5),
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
ThemeTag={
OBJECTS=aw,
Image="Icons.Button"
}
})

local aB=0

p(ax.Activated,function()
if av~=nil and(tick()-aB)<0 then return end

if av~=nil then
aB=tick()+av
end

D(au)
end)

return setmetatable({
CALLBACKS=au,
DESTROY_ELEMENT=ax,
VISIBLE_ELEMENT=ax,
TITLE_LABEL=ay,
DESCRIPTION_LABEL=az,

Title=as,
Description=at,

Parent=self,
Kind="Button"
},ae)
end

function ad:AddTextBox(ar)
local as,at=aj("TextBox",ar)
local au=ak("TextBox",ar[4]or ar.Flag)

local av=ar[2]or ar.Default
local aw=B(ar[3]or ar.Callback)

local ax=ar.Placeholder or ar.PlaceholderText
local ay=ar.ClearOnFocus or ar.ClearTextOnFocus

if av~=nil and type(av)~="string"then
error(`"Tab.AddTextBox.Default". 'string', or 'nil' expected, got {typeof(av)}`,2)
end

if au and type(aa[au])=="string"then
av=aa[au]
end

local az=S[self]
local aA,aB,aC=ai(self,as,at,UDim2.new(1,-150,0,0))

local aD=z("Frame",aA,{
Size=UDim2.new(0,150,0,18),
Position=UDim2.new(1,-10,0.5),
AnchorPoint=Vector2.new(1,0.5),
ThemeTag={
OBJECTS=az,
BackgroundColor3="Colors.Stroke"
},
Elements={
Corner=UDim.new(0,4)
}
})

local aE=z("TextBox",aD,{
Size=UDim2.new(0.85,0,0.85,0),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
BackgroundTransparency=1,
TextScaled=true,
Active=true,
Text="",
PlaceholderText=w.TEXTBOX.PLACEHOLDER_TEXT,
ThemeTag={
OBJECTS=az,
TextColor3="Colors.Text.Default",
Font="Font.Bold"
}
})

local aF={
OBJECTS=az,
Image="Icons.TextBox",
ImageColor3="Colors.Icons"
}

local aG=z("ImageLabel",aD,{
Size=UDim2.new(0,12,0,12),
Position=UDim2.new(0,-5,0.5),
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
ThemeTag=aF
})

if av~=nil then
aE.Text=av
end

if ay~=nil then
aE.ClearTextOnFocus=ay
end

if ax~=nil then
aE.PlaceholderText=ax
end

local aH=ag.TextBox.new(self,aB,aC,aA,aE,aw)local aI=function(

aI)
aF.ImageColor3=aI
G(aG,"ImageColor3",r(n.CurrentTheme,aI),0.5):Play()end


if au~=nil then
p(aE:GetPropertyChangedSignal"Text",function()
aa[au]=aE.Text
end)
end

p(aE.Focused,function()
aI"Colors.Primary"
end)

p(aE.FocusLost,function()
aI"Colors.Icons"
local aJ=aH.TEXTBOX_TEXT_FILTER

if aJ then
local aK=aJ(aE.Text)
if type(aK)=="string"then
aE.Text=aK
end
end

D(aw,aE.Text)
end)

p(aA.Activated,function()
aE:CaptureFocus()
end)

return aH
end

function ad:AddSlider(ar)
local as,at=aj("Slider",ar)
local au=ak("Slider",ar[7]or ar.Flag)

local av=ar[2]or ar.Min
local aw=ar[3]or ar.Max
local ax=ar[4]or ar.Increment
local ay=ar[5]or ar.Default
local az=B(ar[6]or ar.Callback)

if ax~=nil and type(ax)~="number"then
error(`"Tab.AddSlider.Increment". 'number', or 'nil' expected, got {typeof(ax)}`,2)
end

if ay~=nil and type(ay)~="number"then
error(`"Tab.AddSlider.Default". 'number', or 'nil' expected, got {typeof(ay)}`,2)
end

assert(type(av)=="number",`"Tab.AddSlider.Min", 'number' expected, got {typeof(av)}`)
assert(type(aw)=="number",`"Tab.AddSlider.Max", 'number' expected, got {typeof(aw)}`)

local aA=S[self]
local aB=Q[self].Container

local aC,aD,aE=ai(self,as,at,UDim2.new(0.55,0,0,0))

if ay==nil then
ay=av
end

if ax==nil then
ax=1
end

if au~=nil and type(aa[au])=="number"then
ay=aa[au]
end

local aF=z("TextButton",aC,{
Size=UDim2.new(0.45,0,1,0),
Position=UDim2.new(1,0,0,0),
AnchorPoint=Vector2.new(1,0),
AutoButtonColor=false,
BackgroundTransparency=1,
Text=""
})

local aG=z("Frame",aF,{
Size=UDim2.new(1,-20,0,6),
Position=UDim2.fromScale(0.5,0.5),
AnchorPoint=Vector2.new(0.5,0.5),
ThemeTag={
OBJECTS=aA,
BackgroundColor3="Colors.Stroke"
},
Elements={
Corner=UDim.new(0.5,0)
}
})

local aH=z("Frame",aG,{
Size=UDim2.fromScale(0,1),
BorderSizePixel=0,
ThemeTag={
OBJECTS=aA,
BackgroundColor3="Colors.Primary"
},
Elements={
Corner=UDim.new(0.5,0)
}
})

local aI=z("Frame",aG,{
Size=UDim2.new(0,6,0,12),
BackgroundColor3=Color3.fromRGB(220,220,220),
Position=UDim2.fromScale(0,0.5),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=0.2,
Elements={
Corner=UDim.new(0,6)
}
})

local aJ=z("TextLabel",aF,{
Size=UDim2.new(0,50,0,14),
AnchorPoint=Vector2.new(1,0.5),
Position=UDim2.new(0,-1,0.5,0),
BackgroundTransparency=1,
TextSize=12,
TextXAlignment=Enum.TextXAlignment.Right,
ThemeTag={
OBJECTS=aA,
TextColor3="Colors.Text.Default",
Font="Font.SliderValue"
}
})

local aK=z("UIScale",aJ)

local aL=ag.Slider.new(self,aC,aD,aE,az)

aL.Min=av
aL.Max=aw
aL.Increment=ax local aM=function(

aM)
return(aM-av)/(aw-av)end local aN=function(


aN)
return(aN*(aw-av))+av end local aO=function(


aO)
return math.round(aO/ax)*ax end local aP=function(


aP, aQ)
if aP==aL.Value then return end

if au~=nil then
aa[au]=aP
end

task.defer(D,az,aP)
aL.Value=aP

local aR=UDim2.fromScale(aQ,0.5)
local aS=UDim2.fromScale(aQ,1)

aJ.Text=tostring(math.floor(aP*1000)/1000)

if self.Selected then
G(aI,"Position",aR,0.3):Play()
G(aH,"Size",aS,0.3):Play()
else
aI.Position=aR
aH.Size=aS
end end local aQ=function(


aQ)
local aR=math.clamp(aO(aQ),av,aw)
aP(aR,aM(aR))end


aL.WHEN_VALUE_CHANGED=aQ local aR=function(

aR, aS)
local aT=(k.X-aR.X)/aS.X
local aU=math.clamp(aT,0,1)
local aV=aN(aU)
local aW=aO(aV)
local aX=math.clamp(aW,av,aw)
aP(aX,aM(aX))end


local aS=Random.new()
aQ(ay)

p(aF.MouseButton1Down,function()
if v~=false then return end

G(aI,"BackgroundTransparency",0,0.3):Play()
aB.ScrollingEnabled=false
v=true

local aT=aG.AbsolutePosition
local aU=aG.AbsoluteSize

while d:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
aR(aT,aU)
task.wait()
end

v=false
G(aI,"BackgroundTransparency",0.2,0.3):Play()
aB.ScrollingEnabled=true
end)

p(aJ:GetPropertyChangedSignal"Text",function()
if not self.Selected then return end

aK.Scale=0.3
G(aK,"Scale",1.2,0.1):Play()

local aT=G(aJ,"Rotation",aS:NextNumber(-7.5,7.5),0.15)
aT:Play()
aT.Completed:Wait()

G(aK,"Scale",1,0.2):Play()
G(aJ,"Rotation",0,0.1):Play()
end)

return aL
end

function ad:AddDiscordInvite(ar)
local as,at=aj("DiscordInvite",ar)
local au=ar.Icon or ar.Image or ar.Logo
local av=ar.Banner or ar.BannerColor
local aw=ar.Online or ar.MembersOnline
local ax=ar.Members or ar.TotalMembers
local ay=ar.Invite or ar.Link

assert(type(ay)=="string",`"Tab.AddDiscordInvite.Invite". 'string' expected, got {typeof(ay)}`)

if av~=nil and typeof(av)~="Color3"and type(av)~="string"then
error(`"Tab.AddDiscordInvite.Banner". 'nil', 'Color3', or 'string' expected, got {typeof(av)}`,2)
end

if aw~=nil and type(aw)~="number"then
error(`"Tab.AddDiscordInvite.Online". 'number' expected, got {typeof(aw)}`,2)
end

if ax~=nil and type(ax)~="number"then
error(`"Tab.AddDiscordInvite.Members". 'nil', or 'number' expected, got {typeof(ax)}`,2)
end

if F.ZIndexBehavior~=Enum.ZIndexBehavior.Sibling then
F.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
end

local az=S[self]
local aA=Q[self].Container

local aB=z("Frame","Option",aA,{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,148)
})

local aC=z("CanvasGroup",aB,{
Size=UDim2.new(0,178,1,-15),
Position=UDim2.new(0,5,1,0),
AnchorPoint=Vector2.new(0,1),
ClipsDescendants=true,
Elements={
Corner=UDim.new(0,9),
Stroke={
ThemeTag={
Color="Colors.Border.Default"
}
}
},
ThemeTag={
OBJECTS=az,
BackgroundColor3="Colors.Buttons.Default"
}
})

local aD=z("ImageLabel",aC,{
BackgroundColor3=Color3.new(1,1,1),
Size=UDim2.fromScale(1,0.28),
BackgroundTransparency=1
})

local aE=z("TextLabel",aB,{
Position=UDim2.fromOffset(5,0),
Size=UDim2.new(1,0,0,15),
TextColor3=Color3.fromRGB(40,150,255),
TextXAlignment=Enum.TextXAlignment.Left,
BackgroundTransparency=1,
TextSize=9,
Text=ay,
ThemeTag={
OBJECTS=az,
TextColor3="Colors.Link",
Font="Font.Medium"
}
})

local aF=z("ImageLabel",aC,{
Size=UDim2.fromOffset(33,33),
Position=UDim2.new(0,10,0.28,0),
AnchorPoint=Vector2.new(0,0.5),
Image=au,
ThemeTag={
OBJECTS=az,
BackgroundColor3="Colors.Buttons.Default"
},
Elements={
Corner=UDim.new(0,8),
Stroke={
Thickness=2.2,
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
ThemeTag={
OBJECTS=az,
Color="Colors.Buttons.Default"
}
}
}
})

local aG=z("TextLabel",aC,{
Size=UDim2.new(1,-10,0,10),
Position=UDim2.new(0,10,0.44,0),
TextXAlignment=Enum.TextXAlignment.Left,
BackgroundTransparency=1,
TextSize=11,
Text=as,
ThemeTag={
OBJECTS=az,
TextColor3="Colors.Text.Default",
Font="Font.Bold"
}
})

local aH

if aw or ax then
aH=z("Frame",aC,{
Size=UDim2.new(1,-10,0,9),
Position=UDim2.new(0,0,0.52,0),
BackgroundTransparency=1,
Elements={
Padding={
PaddingLeft=UDim.new(0,7),
PaddingRight=UDim.new(0,10)
},
ListLayout={
HorizontalAlignment=Enum.HorizontalAlignment.Left,
VerticalAlignment=Enum.VerticalAlignment.Center,
FillDirection=Enum.FillDirection.Horizontal,
Padding=UDim.new(0,4),
}
}
})local aI=function(

aI, aJ)
return z("Frame",aH,{
Size=UDim2.fromScale(0,1),
AutomaticSize=Enum.AutomaticSize.X,
BackgroundTransparency=1,
Childs={
z("Frame",{
Size=UDim2.fromOffset(3,3),
Position=UDim2.new(0,5,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
BackgroundColor3=aI,
Elements={
Corner=UDim.new(1,0)
}
}),
z("TextLabel",{
Size=UDim2.new(0,0,1,0),
Position=UDim2.new(0,12,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
AutomaticSize=Enum.AutomaticSize.X,
BackgroundTransparency=1,
TextSize=7,
Text=aJ,
ThemeTag={
OBJECTS=az,
TextColor3="Colors.Text.Darker",
Font="Font.Normal"
}
})
}
})end


if aw~=nil then
aI(Color3.fromRGB(67,181,129),K(aw).." Online")
end
if ax~=nil then
aI(Color3.fromRGB(86,101,105),K(ax).." Members")
end
end

local aI=z("TextLabel",aC,{
Size=UDim2.new(1,-50,0,8),
Position=UDim2.new(0,10,aH and 0.6 or 0.56,0),
TextXAlignment=Enum.TextXAlignment.Left,
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
TextSize=8,
Text=at or"",
TextWrapped=true,
ThemeTag={
OBJECTS=az,
TextColor3="Colors.Text.Darker",
Font="Font.Medium"
}
})

local aJ=z("Frame",aC,{
Size=UDim2.new(1,0,0.28,0),
Position=UDim2.fromScale(0,1),
AnchorPoint=Vector2.new(0,1),
BorderSizePixel=0,
ThemeTag={
OBJECTS=az,
BackgroundColor3="Colors.Buttons.Default"
}
})

if#aI.Text>0 then
aJ.Size=UDim2.new(1,0,0.42,0)

z("UIGradient",aJ,{
Rotation=-90,
Transparency=NumberSequence.new{
NumberSequenceKeypoint.new(0.00,0.00),
NumberSequenceKeypoint.new(0.60,0.00),
NumberSequenceKeypoint.new(1.00,1.00)
}
})
end

local aK=z("TextButton",aJ,{
Position=UDim2.new(0.5,0,1,-9),
Size=UDim2.new(1,-18,0,18),
AnchorPoint=Vector2.new(0.5,1),
Text="Go to Server",
Elements={
Corner=UDim.new(0.5,0)
},
ThemeTag={
OBJECTS=az,
BackgroundColor3="Colors.JoinButton",
TextColor3="Colors.Text.Default",
Font="Font.Bold"
}
})

local aL=0

p(aK.Activated,function()
if(tick()-aL)<0 then return end

aL=tick()+5
local aM=aK.Text
aK.Text="Copied to Clipboard!"
setclipboard(ay)
task.wait(4)
aK.Text=aM
end)

if type(av)=="string"then
aD.ScaleType=Enum.ScaleType.Crop
aD.Image=av
elseif typeof(av)=="Color3"then
aD.BackgroundTransparency=0
z("UIGradient",aD,{
Rotation=-15,
Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,av),
ColorSequenceKeypoint.new(1,av:Lerp(Color3.new(1,1,1),0.2))
}
})
end

return setmetatable({
DESTROY_ELEMENT=aB,
VISIBLE_ELEMENT=aB,

Title=as,
Description=at,
DESCRIPTION_LABEL=aI,
TITLE_LABEL=aG,

Kind="DiscordInvite",
Parent=self
},ae)
end

function ad:AddParagraph(ar,as)
assert(type(ar)=="string",`"Tab.AddParagraph[param 1]". 'string' expected, got {typeof(ar)}`)

if as~=nil and type(as)~="string"then
error(`"Tab.AddParagraph[param 2]". 'string', or 'nil' expected, got {typeof(as)}`,2)
end

local at=S[self]
local au,av,aw=ai(self,ar,as,UDim2.new(1,0,0,0))

return setmetatable({
DESTROY_ELEMENT=au,
VISIBLE_ELEMENT=au,
TITLE_LABEL=av,
DESCRIPTION_LABEL=aw,

Title=ar,
Description=as,

Parent=self,
Kind="Paragraph"
},ae)
end

function ad:AddDropdown(ar)
local as,at=aj("Dropdown",ar)
local au=ak("Dropdown",ar[5]or ar.Flag)

local av=ar[2]or ar.Options
local aw=ar[3]or ar.Default
local ax=B(ar[4]or ar.Callback)
local ay=ar.MultiSelect

if aw~=nil and type(aw)~="table"and type(aw)~="string"then
error(`"Tab.AddDropdown.Default". 'string', 'table', or 'nil' expected, got {typeof(aw)}`,2)
end

if av~=nil and type(av)~="table"then
error(`"Tab.AddDropdown.Options". 'table', or 'nil' expected, got {typeof(av)}`,2)
end

if ay~=nil and type(ay)~="boolean"then
error(`"Tab.AddDropdown.MultiSelect". 'boolean', or 'nil' expected, got {typeof(ay)}`,2)
end

if au and type(aa[au])==(ay and"table"or"string")then
aw=aa[au]
end

local az=S[self]
local aA,aB,aC=ai(self,as,at,UDim2.new(1,-150,0,0))

local aD=z("Frame",aA,{
Size=UDim2.new(0,150,0,18),
Position=UDim2.new(1,-10,0.5),
AnchorPoint=Vector2.new(1,0.5),
Elements={
Corner=UDim.new(0,4)
},
ThemeTag={
OBJECTS=az,
BackgroundColor3="Colors.Stroke"
}
})

local aE=z("TextLabel",aD,{
Size=UDim2.new(0.85,0,0.85,0),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.new(0.5,0,0.5,0),
BackgroundTransparency=1,
TextScaled=true,
Text="...",
ThemeTag={
OBJECTS=az,
TextColor3="Colors.Text.Default",
Font="Font.Bold"
}
})

local aF={
OBJECTS=az,
Image="Icons.Dropdown.Open",
ImageColor3="Colors.Icons"
}

local aG=z("ImageLabel",aD,{
Size=UDim2.new(0,15,0,15),
Position=UDim2.new(0,-5,0.5),
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
ThemeTag=aF
})

local aH=ag.Dropdown.new(self,aA,aB,aC,ax)

local aI
local aJ=false
local aK=false

local aL={}
local aM={}
local aN={}
local aO={}

aH.DROPDOWN_OPTIONS=aN
aH.Opened=aK local aP=function(

aP, aQ)
aF.ImageColor3=aP
aF.Image=aQ

G(aG,"ImageColor3",r(n.CurrentTheme,aP),0.35):Play()
aG.Image=r(n.CurrentTheme,aQ)end local aQ=function(


aQ)
aK=aQ
aH.Opened=aQ

local aR=aQ and"Colors.Primary"or"Colors.Icons"
local aS=aQ and"Icons.Dropdown.Close"or"Icons.Dropdown.Open"
aP(aR,aS)end local aR=function()



aQ(false)end local aS=function()



local aS={}
for aT,aU in aM do
if not aU then continue end
aS[#aS+1]=aT
end
return aS end local aT=function(


aT)
local aU=type(aT)=="table"and table.concat(aT,", ")or(aT or"")

if#aU>=100 then
aU=aU:sub(1,97).."..."
end

aE.Text=#aU~=0 and aU or"..."end local aU=function()



aJ=false

local aU=ay and aS()or aI and aI.Name
D(ax,ay and aM or aU)
aT(aU)

if au~=nil then
aa[au]=aU
end end local aV=function()



if not aJ then
aJ=true
task.delay(0.1,aU)
end end local aW=function(


aW)
if ay then
local aX=not aW.Selected
U.SetOptionValue(aW,aX)
aM[aW.Name]=aX
else
if aI==aW then
return nil
elseif aI~=nil then
U.SetOptionValue(aI,false)
end

aI=aW
U.SetOptionValue(aW,true)
end

aV()end local aX=function(


aX)
aX=tostring(aX)
if aO[aX]then return end

local aY={
Name=aX,
DisplayName=aX,
Selected=false
}

if ay and aM[aX]==nil then
aM[aX]=false
end

aO[aX]=aY
aN[#aN+1]=aY
return aY end local aY=function(


aY)
if aK==aY then return end

if not U then
U=al()
end

if aY then
if not U.OpenDropdown(aR)then return end

U.SetHolder(aD)
U.SetMultiSelect(ay)
U.SetOnClicked(aW)
U.SetOptions(aN)
else
U.CloseDropdown()
end

aQ(aY)end local aZ=function(


aZ, a_)
if a_ and type(aZ)=="boolean"then
return aZ==true and aN[a_]
end

return if type(aZ)=="number"then aN[aZ]else aO[tostring(aZ)]end local a_=function(


a_)
a_.Selected=true

if ay then
aM[a_.Name]=true
else
aI=a_
end end local a0=function(...)



local a0=aZ(...)

if a0 then
a_(a0)
elseif ay and type(...)=="string"then
aL[select(1,...)]=true
end end local a1=function()



if not aw then return end

for a1=1,(ay and#aw or 1)do
a0(aw[a1],a1)
end end local a2=function(


a2)
local a3=table.find(aN,a2)

if a3 then
table.remove(aN,a3)
end

if a2.Instance then
a2.Instance:Destroy()
end

aO[a2.Name]=nil end local a3=function(


a3)
if ay then
local a4=a3.Name
return(aM[a4]or aL[a4])==true
else
return aI and aI.Name==a3.Name
end end


aH.ADD_DROPDOWN_OPTION=function(a4)
if type(a4)=="table"then
for a5=1,#a4 do
aH:Add(a4[a5])
end

return nil
end

local a5=aX(a4)

if a5 then
if aH.Opened then
U.CreateOptionTemplate(a5,true)
end

if a3(a5)then
a_(a5)

if a5.Instance then
U.SetOptionValue(a5,a5.Selected)
end
end

aV()
end
end

aH.REMOVE_DROPDOWN_OPTION=function(a4)
local a5=aO[tostring(a4)]
if a5 then
a2(a5)
end
end

aH.CLEAR_DROPDOWN=function()
for a4=#aN,1,-1 do
local a5=aN[a4]
if a5.Instance then
a5.Instance:Destroy()
end

aO[a5.Name]=nil
aN[a4]=nil
end

if aH.Opened then
U.Clear()
end
end

do
if av then
for a4=1,#av do
aX(av[a4])
end
end

if type(aw)=="table"then
a1()
elseif type(aw)=="string"or type(aw)=="number"then
local a4=aZ(aw)

if a4 then
a_(a4)
end
end

if ay then
local a4=aS()
task.defer(D,ax,aM)
aT(a4)
else
local a4=aI
local a5=a4 and a4.Name or""
task.defer(D,ax,a5)
aT(a5)
end
end

p(aA.Activated,function()
aY(not aK)
end)

return aH
end

function ad:Destroy()
assert(type(self)=="table"and self.IS_A_TAB,`"Tab.Destroy". {tostring(self)} is not a tab`)
if self.IS_DESTROYED then return end
local ar=table.find(P,self)
assert(ar,`"Tab.Destroy". failed to destroy '{self.Title}'`)

table.remove(P,ar)

for as,at in Q[self]do
at:Destroy()
end

S[self]:destroy()

Q[self]=nil
S[self]=nil

setmetatable(self,nil)
end

function ad:Select()
if Z==self then
return nil
end

if Z then
R[Z].Unselect()
end

Z=self
R[Z].Select()
end

function ae:SetTitle(ar)
assert(type(ar)=="string",`"Option.SetTitle". 'string' expected, got {typeof(ar)}`)
assert(self.TITLE_LABEL,`"Option.SetTitle". cannot change this option name {self.KIND}:{self.Title}`)

self.TITLE_LABEL.Text=ar
self.Title=ar
return self
end

function ae:SetDescription(ar)
assert(ar==nil or type(ar)=="string",`"Option.SetDescription". 'string', or 'nil' expected, got {typeof(ar)}`)
assert(self.DESCRIPTION_LABEL,`"Option.SetDescription". cannot change this option description {self.KIND}:{self.Title}`)

self.DESCRIPTION_LABEL.Text=ar
self.Description=ar
return self
end

function ae:SetVisible(ar)
assert(typeof(self.VISIBLE_ELEMENT)=="Instance",`"Option.SetVisible". cannot change this option visibility {self.KIND}:{self.Title}`)
assert(type(ar)=="boolean",`"Option.SetVisible". 'boolean' expected, got {typeof(ar)}`)

self.VISIBLE_ELEMENT.Visible=ar
end

function ae:Destroy()
assert(typeof(self.DESTROY_ELEMENT)=="Instance",`"Option.Destroy". cannot destroy this option {self.KIND}:{self.Title}`)

self.DESTROY_ELEMENT:Destroy()
setmetatable(self,nil)

self.Destroyed=true
end

function ae:AddCallback(ar)
assert(self.CALLBACKS,"\"Option.AddCallback\". cannot add callback to this option.")
assert(type(ar)=="function",`"Option.AddCallback[param 1]". 'function' expected, got {typeof(ar)}`)

table.insert(self.CALLBACKS,ar)
return self
end

ae.NewCallback=ae.AddCallback
ae.SetContent=ae.SetDescription
ae.SetDesc=ae.SetDescription

function af:CreateMobileMinimizer(ar)
local as=z("ImageButton",F,{
Size=UDim2.fromOffset(35,35),
Position=UDim2.fromScale(0.17,0.28),
AnchorPoint=Vector2.new(0.5,0.5),
AutoButtonColor=false,
ThemeTag={
BackgroundColor3="Colors.Buttons.Default"
}
})

p(as.Activated,function()
ac:Minimize()
end)

ar.Elements={}

if ar.Corner then
ar.Elements.Corner=ar.Corner
ar.Corner=nil
end

if ar.Stroke then
ar.Elements.Stroke=ar.Stroke
ar.Stroke=nil
end

y.Draggable(as,_,0.5)
y.SetProperties(as,ar)

return as
end

function af:SetKeyCode(ar)
if not aq(ar)then
error(`"Minimizer.SetKeyCode[param 1]". 'KeyCode' expected, got {typeof(ar)}`,2)
end

self.KeyCode=ar
end

function ac:SelectTab(ar)
local as=type(ar)=="number"and P[ar]

if type(ar)=="table"and ar.IS_A_TAB then
as=ar
end

if as then
as:Select()
elseif not as then
assert(type(ar)=="number",`"Window.SelectTab" number or tab expected, got {typeof(ar)}`)
assert(ar>0,`"Window.SelectTab" the number must be greater than 0, value: {ar}`)
assert(ar==math.floor(ar),`"Winow.SelectTab" floor number expected, got {ar}`)

self.SelectedTab=ar
end
end

function ac:Minimize()
Y.Visible=not Y.Visible
end

function ac:MakeTab(ar)
local as=ar[1]or ar.Name or ar.Title
local at=ar[2]or ar.Icon or ar.Image

assert(type(as)=="string",`"Tab.Title" 'string' expected, got {typeof(as)}`)
assert(at==nil or type(at)=="string",`"Tab.Icon" 'string' expected, got {typeof(at)}`)

local au=setmetatable({
Selected=self.SelectedTab==#P+1,
Icon=n:GetIconByName(at),
Title=as,

Parent=self,
IS_A_TAB=true
},ad)

local av=self:GetElements()
local aw=av.TabsContainer
local ax=av.ContainerHolder

local ay,az,aA=ah(self,au,aw)

local aB=G(az,"Size",UDim2.new(1,0,1,0),0.3)
local aC=UDim2.new(1,0,1,150)

local aD=0.45

local aE={
G(aA,"BackgroundTransparency",0,aD),
G(aA,"Size",UDim2.fromOffset(4,13),aD)
}

local aF={
G(aA,"BackgroundTransparency",1,aD),
G(aA,"Size",UDim2.fromOffset(4,4),aD)
}

local aG=x:new()
S[au]=aG local aH=function(

aH)
for aI=1,#aH do
aH[aI]:Play()
end end local aI=function()



aH(aE)
au.Selected=true
aG:changeRendering(true)
aG:update()
az.Parent=ax
az.Size=aC
aB:Play()end local aJ=function()



aH(aF)
au.Selected=false
az.Parent=nil
aG:changeRendering(false)end


R[au]=table.freeze{
Unselect=aJ,
Select=aI
}

Q[au]=table.freeze{
SelectTabButton=ay,
Container=az
}

table.insert(P,au)

p(ay.Activated,function()
au:Select()
end)

if au.Selected then
au:Select()
end

return au
end

function ac:StartWindow(ar)
local as=ar.MinimizeButton
local at=ar.MainFrame
local au=ar.Resizers
local av=ar.TopBar

local aw=ar.SubTitle
local ax=ar.Title

V=ar.Dropdowns
Y=ar.MainFrame
_=ar.UIScale
aa=ar.Flags

local ay=at.Size
local az=0

function ac:MinimizeButton()
if(tick()-az)<0 then
return false
end

if self.Minimized then
as.Image="rbxassetid://10734896206"
G(at,"Size",ay,0.25):Play()
else
ay=at.Size
as.Image="rbxassetid://10734924532"
G(at,"Size",UDim2.fromOffset(at.Size.X.Offset,av.Size.Y.Offset),0.25):Play()
end

for aA,aB in au do
aB.Visible=self.Minimized
end

self.Minimized=not self.Minimized
az=tick()+0.5

return true
end

function ac:GetTitle()
return ax.Text
end

function ac:GetSubTitle()
return aw.Text
end

function ac:SetTitle(aA)
assert(type(aA)=="string",`"Window.SetTitle". 'string' expected, got {typeof(aA)}`)
assert(#aA>0,"\"Window.SetTitle\". the new 'Title' is too short.")

ax.Text=aA
end

function ac:SetSubTitle(aA)
assert(type(aA)=="string",`"Window.SetSubTitle". 'string' expected, got {typeof(aA)}`)
assert(#aA>0,"\"Window.SetSubTitle\". the new 'SubTitle' is too short.")

aw.Text=aA
end

T=z("Frame",F,{
Size=UDim2.new(0,280,1,0),
Position=UDim2.fromScale(1,0),
AnchorPoint=Vector2.new(1,0),
BackgroundTransparency=1,
Elements={
Padding={
PaddingBottom=UDim.new(0,20)
},
ListLayout={
HorizontalAlignment=Enum.HorizontalAlignment.Center,
VerticalAlignment=Enum.VerticalAlignment.Bottom,
SortOrder=Enum.SortOrder.LayoutOrder,
Padding=UDim.new(0,20)
}
}
})

X=z("TextButton","OutBox",{
Size=UDim2.fromScale(1,1),
BackgroundTransparency=0.3,
AutoButtonColor=false,
Text="",
ThemeTag={
BackgroundColor3="Colors.Buttons.Default"
},
Childs={
at:FindFirstChildOfClass"UICorner":Clone(),
z("Frame","Template",{
Size=UDim2.new(0.35,60,0.20,80),
Position=UDim2.fromScale(0.5,0.5),
AnchorPoint=Vector2.new(0.5,0.5),
Active=true,
Elements={
Corner=UDim.new(0,6),
Gradient={
Rotation=45,
ThemeTag={
Color="Colors.Background"
}
}
},
Childs={
z("TextLabel","Title",{
Size=UDim2.new(1,-20,0,20),
TextTruncate=Enum.TextTruncate.AtEnd,
TextSize=15,
Position=UDim2.new(0.5,0,0,28),
AnchorPoint=Vector2.new(0.5,0),
BackgroundTransparency=1,
ThemeTag={
Font="Font.ExtraBold",
TextColor3="Colors.Text.Default"
}
}),
z("TextLabel","Description",{
Position=UDim2.new(0.5,0,0,46),
Size=UDim2.new(1,-20,0,0),
AnchorPoint=Vector2.new(0.5,0),
TextWrapped=true,
TextSize=11,
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
ThemeTag={
TextColor3="Colors.Text.Darker",
Font="Font.Medium"
}
}),
z("Frame","Options",{
Size=UDim2.new(1,-20,0.15,18),
Position=UDim2.new(0.5,0,1,-10),
AnchorPoint=Vector2.new(0.5,1),
BackgroundTransparency=1,
Elements={
Padding={
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
PaddingBottom=UDim.new(0,30),
PaddingTop=UDim.new(0,30)
},
ListLayout={
HorizontalAlignment=Enum.HorizontalAlignment.Right,
VerticalAlignment=Enum.VerticalAlignment.Center,
FillDirection=Enum.FillDirection.Horizontal
}
}
})
}
})
}
})

X.Template:SetAttribute("OriginalSize",X.Template.Size)

p(X.Activated,function()
if W~=nil and not W.Closing and not W.Closed then
W:Close()
end
end)

ac.StartWindow=nil
end

function ac:DeleteFlags()
return aa()
end

function ac:SetFlag(ar,as)
assert(type(ar)=="string",`"Window.SetFlag[param 1]". 'string' expected, got {typeof(ar)}`)

if ap[typeof(as)]~=true then
local at={}

for au,av in ap do
table.insert(at,au)
end

return error(`"Window.SetFlag[param 2]". '{table.concat(at,"', '")}' expected, got {typeof(as)}`,2)
end

aa[ar]=as
end

function ac:GetFlag(ar)
return aa[ar]
end

function ac:NewMinimizer(ar)
local as=type(ar)=="table"and(ar[1]or ar.KeyCode)or ar

if not aq(as)then
error(`"Window.NewMinimizer.KeyCode". 'KeyCode' expected, got {typeof(as)}`,2)
end

local at=setmetatable({
KeyCode=as
},af)

p(d.InputBegan,function(au)
if au.KeyCode==at.KeyCode then
ac:Minimize()
end
end)

return at
end

function ac:Dialog(ar)
if self.Minimized then
while not self:MinimizeButton()do task.wait()end
end

if W then
W:Close(true)
end

local as=ar.Title or ar.Name
local at=ar.Content or ar.Description
local au=ar.Options

assert(type(as)=="string",`"Window.Dialog.Title". 'string' expected, got {typeof(as)}`)
assert(type(at)=="string",`"Window.Dialog.Content". 'string' expected, got {typeof(at)}`)
assert(type(au)=="table",`"Window.Dialog.Options". 'table' expected, got {typeof(au)}`)
assert(#au>0,"\"Window.Dialog.Options\". requires one or more options.")local av=function()


local av=X.Template
local aw=av.Description
local ax=av.Title

local ay=av:GetAttribute"OriginalSize"
local az=UDim2.new(ay.X.Scale*1.2,ay.X.Offset,ay.Y.Scale*1.2,ay.Y.Offset)

av.Size=az
X.Parent=Y
aw.Text=at
ax.Text=as

G(av,"Size",ay,0.3):Play()

local aA=ag.Dialog.new(aw,ax)
aA.NEW_SIZE=az
aA.TEMPLATE=av

for aB,aC in av.Options:GetChildren()do
if aC:IsA"GuiObject"then
aC:Destroy()
end
end

for aB=#au,1,-1 do
aA:NewOption(au[aB])
end

return aA end


W=av()
return W
end

function ac:SetNotifyDefaultIcon(ar)
assert(type(ar)=="string",`"Window.SetNotifyDefaultIcon[param 1]". 'string' expected, got {typeof(ar)}`)

ab=ar
end

function ac:Notify(ar)
if type(ar)~="table"then
ar={}
end

local as=ar[1]or ar.Name or ar.Title
local at=ar[2]or ar.Content
local au=ar[3]or ar.Icon or ar.Image
local av=ar[4]or ar.Duration or ar.Countdown or ar.Time

if self.NOTIFICATION_GROUP then
if av==nil then av=self.Duration end
if at==nil then at=self.Content end
if as==nil then as=self.Title end
if au==nil then au=self.Icon end
end

assert(type(as)=="string",`"Window.Notify.Title". 'string' expected, got {typeof(as)}`)
assert(type(at)=="string",`"Window.Notify.Content". 'string' expected, got {typeof(as)}`)
assert(au==nil or type(au)=="string",`"Window.Notify.Icon". 'nil' or 'string' expected, got {typeof(au)}`)

if av~=nil and type(av)~="number"then
error(`"Window.Notify.Time". 'number', or 'nil' expected, got {typeof(av)}`,2)
elseif av==nil then
av=5
end

local aw=z("Frame","Notification",T,{
Size=UDim2.new(0.85,0,0,60),
BackgroundTransparency=1,
AutomaticSize=Enum.AutomaticSize.Y
})

local ax=z("TextButton",aw,{
AutomaticSize=Enum.AutomaticSize.Y,
Size=UDim2.fromScale(1,1),
AutoButtonColor=false,
Text="",
ThemeTag={
BackgroundTransparency="BackgroundTransparency"
},
Elements={
Corner=UDim.new(0,9),
Gradient={
Rotation=45,
ThemeTag={
Color="Colors.Background"
}
}
}
})

local ay=z("UIScale",aw)

local az=z("Frame","Holder",ax,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Elements={
ListLayout={
SortOrder=Enum.SortOrder.LayoutOrder,
VerticalAlignment=Enum.VerticalAlignment.Center,
Padding=UDim.new(0,4)
},
Padding={
PaddingBottom=UDim.new(0,8),
PaddingTop=UDim.new(0,8),
PaddingLeft=UDim.new(0,40)
}
}
})

local aA=z("TextLabel",az,{
Size=UDim2.new(1,0,0,20),
TextTruncate=Enum.TextTruncate.AtEnd,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Bottom,
BackgroundTransparency=1,
TextSize=14,
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.Bold"
}
})

local aB=z("TextLabel",az,{
Size=UDim2.new(1,0,0,20),
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
TextWrapped=true,
TextSize=12,
ThemeTag={
TextColor3="Colors.Text.Dark",
Font="Font.Normal"
}
})

local aC=z("ImageLabel",ax,{
Size=UDim2.fromOffset(24,24),
Position=UDim2.new(0,8,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
BackgroundTransparency=1,
ThemeTag={
ImageColor3="Colors.Icons"
}
})

local aD=z("TextLabel",ax,{
Size=UDim2.new(0,40,0,16),
Position=UDim2.new(1,-10,0,8),
AnchorPoint=Vector2.new(1,0),
BackgroundTransparency=1,
TextSize=10,
ThemeTag={
TextColor3="Colors.Text.Darker",
Font="Font.Normal"
}
})

local aE=false

local aF=G(ay,"Scale",1.22,0.35)
local aG=G(ay,"Scale",1.00,0.35)

local aH=setmetatable({
TITLE_LABEL=aA,
DESCRIPTION_LABEL=aB,
VISIBLE_ELEMENT=aw,
DESTROY_ELEMENT=aw,
NOTIFICATION=ax,

Kind="Notification",
Closed=false,
Parent=self
},ae)

function aH:Close()
if self.Closed==true then return end

self:Destroy()
self.Closed=true

local aI=G(ax,"Position",UDim2.fromScale(3,0),0.8)
aI:Play()
aI.Completed:Wait()
aw:Destroy()
end local aI=function()


au=n:GetIconByName(au or ab)
aC.Image=au

if not L(au)then
aC.Visible=false
az.UIPadding.PaddingLeft=UDim.new(0,15)
end

ax.Position=UDim2.fromScale(3,0)
G(ax,"Position",UDim2.fromScale(0,0),0.35):Play()

aA.Text=as
aB.Text=at

local aI=ax.MouseLeave

while av>0 do
aD.Text=N(av)
if aE==true then aI:Wait()end
av-=task.wait()
end

aH:Close()end


p(ax.MouseButton1Down,function()aF:Play()aE=true end)
p(ax.MouseLeave,function()aG:Play()aE=false end)

task.defer(aI)

return aH
end

function ac:NewNotifyGroup(ar)
local as=ar[1]or ar.Name or ar.Title
local at=ar[2]or ar.Content
local au=ar[3]or ar.Icon or ar.Image
local av=ar[4]or ar.Duration or ar.Countdown or ar.Time

if as~=nil and type(as)~="string"then
error(`"Window.NewNotifyGroup.Title". 'string', or 'nil' expected, got {typeof(as)}`,2)
end

if at~=nil and type(at)~="string"then
error(`"Window.NewNotifyGroup.Content". 'string', or 'nil' expected, got {typeof(at)}`,2)
end

if au~=nil and type(au)~="string"then
error(`"Window.NewNotifyGroup.Icon". 'string', or 'nil' expected, got {typeof(au)}`,2)
end

if av~=nil and type(av)~="number"then
error(`"Window.NewNotifyGroup.Time". 'number', or 'nil' expected, got {typeof(av)}`,2)
end

return{
NOTIFICATION_GROUP=true,
Notify=ac.Notify,

Duration=av,
Content=at,
Title=as,
Icon=au,
}
end

ac.NewNotificationGroup=ac.NewNotifyGroup
ac.SetDefaultNotifyIcon=SetNotifyDefaultIcon
ac.Notificafion=ac.Notify

O.Window=ac
end local aa=function(

aa, ab)
local ac=ab.Size.Y.Offset
local ad=UDim2.new(0,aa.TabSize or n.Default.TabSize,1,-ac)
local ae=UDim2.new(1,-ad.X.Offset,1,-ac)

local af=z("ScrollingFrame","TabsScroll",{
AutomaticCanvasSize=Enum.AutomaticSize.Y,
ScrollingDirection=Enum.ScrollingDirection.Y,
Position=UDim2.new(0,0,1,0),
AnchorPoint=Vector2.new(0,1),
ScrollBarThickness=2.2,
BackgroundTransparency=1,
ScrollBarImageTransparency=0.2,
CanvasSize=UDim2.new(),
BorderSizePixel=0,
Size=ad,
ThemeTag={
ScrollBarImageColor3="Colors.ScrollBar"
},
Elements={
Padding={
PaddingLeft=UDim.new(0,10),
PaddingRight=UDim.new(0,10),
PaddingTop=UDim.new(0,10),
PaddingBottom=UDim.new(0,10)
},
ListLayout={
Padding=UDim.new(0,5)
}
}
})

local ag=z("Frame","Containers",{
Size=ae,
AnchorPoint=Vector2.new(1,1),
Position=UDim2.new(1,0,1,0),
BackgroundTransparency=1,
ClipsDescendants=true
})

return af,ag end


function n:GetIconByName(ab)
if ab==nil then return end
assert(ab,`"Library.GetIconByName". 'string' expected, got {typeof(ab)}`)

if L(ab)or#ab==0 then
return ab
end

local ac=J(ab)

if self.Icons[ac]then
return"rbxassetid://"..self.Icons[ac]
end

for ad,ae in self.Icons do
if ad:find(ac,1,true)then
return"rbxassetid://"..ae
end
end
end

function n:IsValidTheme(ab)
assert(type(ab)=="string",`"Library.IsValidTheme". string extected, got {typeof(ab)}`)

return self.Themes[ab]~=nil
end

function n:GetThemes()
local ab={}
for ac,ad in self.Themes do
table.insert(ab,ac)
end
return ab
end

function n:GetTheme(ab)
assert(ab==nil or type(ab)=="string",`"Library.GetTheme". 'string' expected, got {typeof(ab)}`)

if ab==nil then
return self.CurrentTheme
end

local ac=self.Themes[ab]
assert(ac~=nil,`"Library.GetTheme". theme not found: {ab}`)
return ac
end

function n:SetTheme(ab)
assert(type(ab)=="string",`"Library.SetTheme". string extected, got {typeof(ab)}`)
local ac=self.Themes[ab]
assert(ac,`"Library.SetTheme". theme not found: {ab}`)

self.CurrentTheme=ac
self.WindowSettings.SelectedTheme=ac.Name

x:update()
end

function n:SetUIScale(ab)
local ac=w.MIN_SCALE
local ad=w.MAX_SCALE

assert(type(ab)=="number",`"Library.SetUIScale". 'number' expected, got {typeof(ab)}`)
assert(ab>=ac and ab<=ad,`"Library.SetUIScale". Min Scale: {ac}, Max Scale: {ad}`)

F.Scale.Scale=M(ab)
end

function n:GetMaxScale()
return w.MAX_SCALE
end

function n:GetMinScale()
return w.MIN_SCALE
end

function n:GetCurrentTheme()
if not self.LOADED_UI_LIBRARY then
return error("failed to get current theme: UI is not loaded",2)
end
return self.CurrentTheme
end

function n:Destroy()
for ab,ac in self.Connections do
ac:Disconnect()
end

if F and F:GetAttribute"UID"==self.SCREENGUI_UID then
pcall(F.Destroy,F)
end
end

function n:MakeWindow(ab)
if self.LOADED_UI_LIBRARY then
return error("you can create only 1 Window",2)
end

local ac=math.random()
F:SetAttribute("UID",ac)
self.SCREENGUI_UID=ac
F:ClearAllChildren()

local ad=z("UIScale","Scale",F,{
Scale=M(1)
})

local ae={
Title=ab[1]or ab.Name or ab.Title,
SubTitle=ab[2]or ab.SubName or ab.SubTitle,
ScriptFolder=ab[3]or ab.ScriptFolder or ab.FolderName
}

assert(type(ae.Title)=="string",`"Window.Title". 'string' expected, got {typeof(ae.Title)}`)
assert(type(ae.SubTitle)=="string",`"Window.SubTitle". 'string' expected, got {typeof(ae.SubTitle)}`)

if ae.ScriptFolder~=nil and type(ae.ScriptFolder)~="string"then
return error(`"Window.ScriptFolder". 'string', or nil expected, got {typeof(ae.ScriptFolder)}`,2)
end

if ae.ScriptFolder~=nil and string.find(ae.ScriptFolder,"/")then
return error("\"Window.ScriptFolder\" is not valid, unexpected char \"/\"",2)
end

local af=(function()
local af=ae.ScriptFolder
local ag=false

local ah,ai=pcall(function()
return af and f:JSONDecode(readfile(`{af}/LibrarySettings.json`))
end)

if type(ai)~="table"then
ai={}
end local aj=function()


ag=false

return pcall(function()
return u(`{af}/LibrarySettings.json`,f:JSONEncode(ai))
end)end local ak=function(


ak, al, am)
rawset(ai,al,am)

if af and not ag then
ag=true
task.delay(0.5,aj)
end end


return setmetatable({},{
__newindex=ak,
__index=ai
})
end)()

local ag=(function()
local ag=ae.ScriptFolder
local ah=false

local ai,aj=pcall(function()
return ag and f:JSONDecode(readfile(`{ag}/ScriptFlags.json`))
end)

if type(aj)~="table"then
aj={}
end local ak=function()


ah=false

return pcall(function()
u(`{ag}/ScriptFlags.json`,f:JSONEncode(aj))
end)end local al=function(


al, am, an)
rawset(aj,am,an)

if ag and not ah then
ah=true
task.delay(0.5,ak)
end end local am=function()



table.clear(aj)
return pcall(function()
return ag and(delfile or deletefile)(`{ag}/ScriptFlags.json`)
end)end


return setmetatable({},{
__newindex=al,
__call=am,
__index=aj
})
end)()

self.ThemesObjects=x
self.WindowSettings=af
self.Flags=ag

self.Icons=(function()
local ah=ae.ScriptFolder

local ai,aj=pcall(function()
return loadstring(readfile(`{ah}/Icons.lua`))()
end)

if ai and type(aj)=="table"then
return aj
end

local ak=`https://raw.githubusercontent.com/{self.Information.GitHubOwner}`
local al=`{ak}/Library/refs/heads/main/redz-V5-remake/Utils/Icons.lua`
local am local an=function()


return u(`{ah}/Icons.lua`,am)end


local ao,ap=pcall(function()
am=game:HttpGet(al)
return loadstring(am)()
end)

if ao and type(ap)=="table"then
if type(am)=="string"then
pcall(an)
end

return ap
end

return{}
end)()

if type(af.SelectedTheme)=="string"and self:IsValidTheme(af.SelectedTheme)then
self:SetTheme(af.SelectedTheme)
else
self:SetTheme(self.Default.Theme)
end

self.LOADED_UI_LIBRARY=true

local ah=self.Default.UISize

if af and type(af.UISize)=="table"then
local ak,al=unpack(af.UISize)

if type(ak)=="number"and type(al)=="number"then
local am=F.AbsoluteSize
ak=math.clamp(ak,430,1000)
al=math.clamp(al,200,500)
ah=UDim2.fromOffset(ak,al)
end
end

local ak=z("Frame","Window",F,{
Position=UDim2.new(0.5,-ah.X.Offset/2,0.5,-ah.Y.Offset/2),
Active=true,
Size=ah,
ThemeTag={
BackgroundTransparency="BackgroundTransparency"
},
Elements={
Corner=UDim.new(0,8),
Gradient={
Rotation=45,
ThemeTag={
Color="Colors.Background"
}
}
}
})

p(ak.Destroying,function()
self:Destroy()
end)

p(F:GetAttributeChangedSignal"UID",function()
self:Destroy()
ak:Destroy()
end)

y.Draggable(ak,ad,0.5)

local al=z("Folder","Components",ak)
local am=z("Folder","Dropdowns",F)

local an=z("Frame","TopBar",al,{
Size=UDim2.new(1,0,0,28),
BackgroundTransparency=1
})

local ao=z("TextLabel","Title",an,{
TextXAlignment=Enum.TextXAlignment.Left,
AutomaticSize=Enum.AutomaticSize.XY,
Position=UDim2.new(0,15,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
Text=ae.Title,
TextSize=12,
BackgroundTransparency=1,
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.Bold"
},
Childs={
z("TextLabel","SubTitle",{
Size=UDim2.fromScale(0,1),
AutomaticSize="X",
AnchorPoint=Vector2.new(0,1),
Position=UDim2.new(1,5,0.9),
Text=ae.SubTitle,
BackgroundTransparency=1,
TextXAlignment="Left",
TextYAlignment="Bottom",
TextSize=8,
ThemeTag={
TextColor3="Colors.Text.Dark",
Font="Font.Normal"
}
})
}
})

local ap=z("Folder","Buttons",an,{
Childs={
z("ImageButton","Close",{
Size=UDim2.new(0,18,0,18),
Position=UDim2.new(1,-10,0.5),
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
BackgroundColor3=Color3.fromRGB(255,35,35),
AutoButtonColor=false,
ThemeTag={
Image="Icons.Close"
},
Elements={
Corner=UDim.new(0.2,0)
}
}),
z("ImageButton","Minimize",{
Size=UDim2.new(0,18,0,18),
Position=UDim2.new(1,-35,0.5),
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
BackgroundColor3=Color3.new(1,1,1),
Image="rbxassetid://10734896206",
AutoButtonColor=false,
Elements={
Corner=UDim.new(0.2,0)
}
})
}
})

local aq=ap.Minimize
local ar=ap.Close

local as=setmetatable(ae,{
__index=O.Window
})

local at,au=aa(af,an)

at.Parent=al
au.Parent=al

local av=table.freeze{
ContainerHolder=au,
TabsContainer=at,
Components=al,
MainFrame=ak
}

function as:GetElements()
return av
end

local aw=z("Frame","ControlWindowSize",ak,{
Size=UDim2.new(0,35,0,35),
Position=ak.Size,
AnchorPoint=Vector2.new(0.8,0.8),
BackgroundTransparency=1,
Active=true,
Elements={
Corner=UDim.new(0,6)
},
ThemeTag={
BackgroundColor3="Colors.OnPrimary"
}
})

local ax=z("Frame","ControlTabsSize",ak,{
Size=UDim2.new(0,16,0.75,-30),
Position=UDim2.new(0,at.Size.X.Offset,0.5,15),
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=1,
Active=true,
Elements={
Corner=UDim.new(0,6)
},
ThemeTag={
BackgroundColor3="Colors.OnPrimary"
}
})local ay=function(

ay)
local az=ay:GetAttribute"Resizing"
ay:SetAttribute("Resizing",tick())

if az and(tick()-az)<=0.1 then
return nil
end

G(ay,"BackgroundTransparency",0.5,0.3):Play()
while tick()-ay:GetAttribute"Resizing"<=0.1 do task.wait()end
G(ay,"BackgroundTransparency",1,0.4):Play()end


p(aw:GetPropertyChangedSignal"Position",function()
ay(aw)
local az=aw.Position
ak.Size=az
af.UISize={az.X.Offset,az.Y.Offset}
end)

p(ax:GetPropertyChangedSignal"Position",function()
ay(ax)
local az=ax.Position
at.Size=UDim2.new(0,az.X.Offset,1,-an.Size.Y.Offset)
au.Size=UDim2.new(1,-at.Size.X.Offset,1,-an.Size.Y.Offset)
af.TabSize=az.X.Offset
end)

y.Draggable(aw,ad,0.68,function(az,aA,aB,aC)
return UDim2.fromOffset(math.clamp(aA,430,1000),math.clamp(aC,200,500))
end)

y.Draggable(ax,ad,0.68,function(aA,aB)
return UDim2.new(0,math.clamp(aB,135,210),0.5,15)
end)

local aA={
Title="Close Window?",
Content="You Want Close UI?",
Options={
{
Title="Yes",
Callback=function()self:Destroy()end
},
{
Title="No"
}
}
}

p(aq.MouseEnter,function()aq.BackgroundTransparency=0.65 end)
p(aq.MouseLeave,function()aq.BackgroundTransparency=1.00 end)

p(ar.MouseEnter,function()ar.BackgroundTransparency=0.65 end)
p(ar.MouseLeave,function()ar.BackgroundTransparency=1.00 end)

as.SetUIScale=self.SetUIScale
as.SUBTITLE_LABEL=ao.SubTitle
as.TITLE_LABEL=ao

local aB=as:StartWindow{
Resizers={aw,ax},
MinimizeButton=aq,
Dropdowns=am,
MainFrame=ak,
TopBar=an,

SubTitle=ao.SubTitle,
Title=ao,

UIScale=ad,
Flags=ag
}

p(aq.Activated,function()
as:MinimizeButton()
end)

p(ar.Activated,function()
as:Dialog(aA)
end)

return as
end

return n
