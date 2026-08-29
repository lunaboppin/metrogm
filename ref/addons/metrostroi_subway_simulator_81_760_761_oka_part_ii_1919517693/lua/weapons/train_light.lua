AddCSLuaFile()

SWEP.Author = "Hell"
if CLIENT then
	if Metrostroi.ChoosedLang == "ru" then
		SWEP.Instructions = "RUS:R  -  Смена режима(обычный фонарь/подача специальных сигналов),  ЛКМ - включение/выключение фонаря,ПКМ - переключение специальных сигналов(Ж,З,К)"
	else
		SWEP.Instructions = "ENG:R-Change Mode(light/special signals), Left Mouse - On/off light, Right Mouse - Change special signals(yellow,green,red)"
	end
end
SWEP.PrintName = "Train Light"

SWEP.Slot				= 3
SWEP.SlotPos			= 2

if SERVER then
	AddCSLuaFile("train_light.lua")
end
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category           = "Metrostroi"

SWEP.ViewModel = "models/lamps/torch.mdl"
SWEP.WorldModel = "models/lamps/torch.mdl"
SWEP.ViewModelBoneMods = {
//	["ValveBiped.Bip01"] = { scale = Vector(1.001, 1.001, 1.001), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}
SWEP.HoldType = "physgun"
SWEP.ViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ViewModel = "models/weapons/v_hands.mdl"
SWEP.WorldModel = "models/lamps/torch.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.VElements = { 
	["lampv"] = { type = "Model", model = "models/metrostroi_train/81-760/81_760_handle_light.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(14.258, 7.853, -10), angle = Angle( 0, 200, -90), size = Vector(1,1,1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["lampw"] = { type = "Model", model = "models/metrostroi_train/81-760/81_760_handle_light.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.861, 0, -1.3), angle = Angle(-10, 180, 153.419), size = Vector(0.97, 0.97, 0.97), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

local WElements = {
	["lamp1"] = { type = "Model", model = "models/metrostroi_train/81-760/81_760_handle_light.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 1.557, -2.597), angle = Angle(0, 180, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

local SwitchSound = Sound( "HL2Player.FlashLightOn" )

function SWEP:PrimaryAttack()

	if SERVER and IsFirstTimePredicted() then
		self.lamp:Toggle()
		--self:EmitSound(SwitchSound)
	end
	self:EmitSound(SwitchSound)
end

function SWEP:Deploy()

	if SERVER then
		self.lamp = ents.Create( "gmod_lamp" )

		if ( !IsValid( self.lamp ) ) then return end
		
		
		self.lamp:SetModel( "models/maxofs2d/light_tubular.mdl" )
		self.lamp:SetCollisionGroup( COLLISION_GROUP_WORLD )
		self.lamp:SetFlashlightTexture( "effects/flashlight001" )
		self.lamp:SetLightFOV( 69 )
		self.lamp:SetColor( Color( 255, 255, 255, 1 ) )
		self.lamp:SetRenderMode(1)
		self.lamp:SetDistance( 1500 )
		self.lamp:SetBrightness( 5 )
		self.lamp:Switch( true )
		
		self.lamp:SetParent(self.Owner,self.Owner:LookupAttachment("anim_attachment_RH"))
		--self.lamp:SetLocalPos( Vector( 7, 3, -5 ) )
		self.lamp:SetLocalPos(Vector(4,2,-7))
		self.lamp:SetLocalAngles( Angle( 0, -5, 0 ) )
		self.lamp:Spawn()
		
		self:EmitSound(SwitchSound)
		
	end
end
 
function SWEP:Reload() 
	if CurTime()-self:GetNW2Float("reloadtimer",0) >= 0 then
		self:SetNW2Float( "reloadtimer", CurTime() + 1 )
		self:SendWeaponAnim( ACT_VM_RELOAD )
	else
		return
	end
	if SERVER then
		if self.lamp:GetOn() then
			self.lamp:Toggle()
		end
		self.SigType = not self.SigType
		self:SetNW2Bool("SigType",self.SigType)
		if self.SigType then
			self.lamp:SetLocalPos(Vector(4,4,-4))
		else
			self.lamp:SetLocalPos(Vector(4,2,-7))			
		end
	end
	if CLIENT then
		self.SigType = self:GetNW2Bool("SigType")
	end
	if self.SigType then
		self.VElements["lampv"].angle = Angle( 0, 200, -90)
		self.WElements["lampw"].angle =  Angle(-10, 180, 153.419)
	else
		self.VElements["lampv"].angle = Angle( 180, 200, -90)
		self.WElements["lampw"].angle =  Angle(-190, 180, 53.419)
	end
	if SERVER and IsValid(self.lamp) then
		if not self.SigType then
			self.lamp:SetColor(Color(255,255,255,1))
		elseif self.SigType then
			if self.Sig == 1 then
				self.lamp:SetColor(Color(255,255,0,1))
			elseif self.Sig == 2 then
				self.lamp:SetColor(Color(0,255,0,1))
			elseif self.Sig == 3 then
				self.lamp:SetColor(Color(255,0,0,1))
			end		
		end
	end
end

function SWEP:SecondaryAttack()
	if SERVER and self.SigType and IsValid(self.lamp) then
		self.Sig = self.Sig == 3 and 1 or self.Sig+1	
		if self.Sig == 1 then
			self.lamp:SetColor(Color(255,255,0,1))
		elseif self.Sig == 2 then
			self.lamp:SetColor(Color(0,255,0,1))
		elseif self.Sig == 3 then
			self.lamp:SetColor(Color(255,0,0,1))
		end
	end
end

function SWEP:Initialize()
	
	self:SetHoldType("physgun")
	self.SigType = false
	self.Sig = 1
	

	if CLIENT then
	
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements)
		self:CreateModels(self.WElements)
		
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				vm:SetColor(Color(255,255,255,1))
				vm:SetMaterial("Debug/hsv")
			end
		end
		
	end

end

function SWEP:Holster()
	
	if SERVER then
		SafeRemoveEntity( self.lamp )
		self.lamp = nil
	end
	
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	
	return true
end

function SWEP:OnRemove()
	self:Holster()
end

if CLIENT then

	local matLight = Material( "sprites/light_ignorez" )
	local matBeam = Material( "effects/lamp_beam" )
	
	function SWEP:DrawWorldModel()
		
		render.SetMaterial( matLight )
		render.DrawSprite( self:GetPos(), 10, 10, Color(255,255,255), 1 )
		
	end

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then
			
			self.vRenderOrder = {}

			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end

		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then

			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end

	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v)
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end
do return end