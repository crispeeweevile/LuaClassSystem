require("Classes")

function clamp(n, m, mx)
    if n > mx then
        return mx
    elseif n < m then
        return m
    else
        return n
    end
end

Character = class({
    Damage = 10,
    MaxHealth = 100,
    Health = 100,
    LifeSteal = 0,

    IsDead = function (self)
        if self.Health <= 0 then
            return true
        elseif self.Health > self.MaxHealth then
            return true
        else
            return false
        end
    end,

    SetHealth = function(self, amt)
        self.Health = math.ceil(clamp(amt, 0, self.MaxHealth))
    end,

    DoDamage = function (self,other)
        oldhp = {other.Health}
        other:SetHealth(other.Health-self.Damage)
        self:SetHealth(self.Health + oldhp[1]*self.LifeSteal)
        if other:IsDead() then
            print("Killed opponent")
        end
    end,
})

BloodMage = class(Character, {
    LifeSteal = .1,
    Damage = 7,
    new = function (self)
        return setmetatable(deepcopy(self), getmetatable(self))
    end
})

Warrior = class(Character, {
    Damage = 15,
    Health = 75,
    MaxHealth = 75,
    new = function (self)
        return setmetatable(deepcopy(self), getmetatable(self))
    end
})

x = Warrior()
z = BloodMage()

x:DoDamage(z)
print(z.Health, x.Health)
z:DoDamage(x)
print(z.Health, x.Health)
z:DoDamage(x)
print(z.Health, x.Health)
z:DoDamage(x)
print(z.Health, x.Health)
z:DoDamage(x)
print(z.Health, x.Health)
z:DoDamage(x)
print(z.Health, x.Health)
z:DoDamage(x)
print(z.Health, x.Health)
z:DoDamage(x)
print(z.Health, x.Health)
z:DoDamage(x)
print(z.Health, x.Health)
z:DoDamage(x)
print(z.Health, x.Health)
z:DoDamage(x)
print(z.Health, x.Health)
z:DoDamage(x)
print(z.Health, x.Health)
z:DoDamage(x)
print(z.Health, x.Health)
