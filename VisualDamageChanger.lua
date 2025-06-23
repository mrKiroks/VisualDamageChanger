local memory = require 'memory'

local apply_damage_address = 0x6C24B0 -- �������� �� ���������� ����� ��� ����� ������ ����

-- ��������� ����� ������������ �������
local original_function = memory.read(apply_damage_address)

-- ���������� ���� �������-���
local function apply_damage_hook(ptr, edx, compId, intensity, a5)
    if compId == 1 then -- �������� �� ������
        return 0 -- ��������� �����������
    end
    -- �������� ������������ �������
    return memory.call(original_function, ptr, edx, compId, intensity, a5)
end

-- ������������� ���, ������� ��������� �� ���� �������
memory.write(apply_damage_address, apply_damage_hook)

-- �������� ���� (����� ���� �� ����� � ��������� ������� MoonLoader)
function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
    while not isSampAvailable() do wait(100) end

    -- ��������� ���
    memory.write(apply_damage_address, apply_damage_hook)

    while true do
        wait(0)
    end
end