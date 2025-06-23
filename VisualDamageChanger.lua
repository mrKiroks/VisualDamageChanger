local memory = require 'memory'

local apply_damage_address = 0x6C24B0 -- Замените на актуальный адрес для вашей версии игры

-- Сохраняем адрес оригинальной функции
local original_function = memory.read(apply_damage_address)

-- Определяем нашу функцию-хук
local function apply_damage_hook(ptr, edx, compId, intensity, a5)
    if compId == 1 then -- Проверка на колесо
        return 0 -- Запрещаем повреждение
    end
    -- Вызываем оригинальную функцию
    return memory.call(original_function, ptr, edx, compId, intensity, a5)
end

-- Устанавливаем хук, заменяя указатель на нашу функцию
memory.write(apply_damage_address, apply_damage_hook)

-- Основной цикл (может быть не нужен в некоторых версиях MoonLoader)
function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
    while not isSampAvailable() do wait(100) end

    -- Применяем хук
    memory.write(apply_damage_address, apply_damage_hook)

    while true do
        wait(0)
    end
end