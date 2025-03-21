---@meta _
---@diagnostic disable: duplicate-set-field


---==================================================================================================================---
---  VANILLAMODELAPI                                                                                                 ---
---==================================================================================================================---

---An API for handling the vanilla player model.
---@class VanillaModelAPI
---The entire vanilla player model.
---> `HEAD`, `BODY`, `LEFT_ARM`, `RIGHT_ARM`, `LEFT_LEG`, `RIGHT_LEG`, `HAT`, `JACKET`, `LEFT_SLEEVE`, `RIGHT_SLEEVE`,
---> `LEFT_PANTS`, `RIGHT_PANTS`, `CAPE_MODEL`, `FAKE_CAPE`, `HELMET_ITEM`, `HELMET_HEAD`, `HELMET_HAT`,
---> `CHESTPLATE_BODY`, `CHESTPLATE_LEFT_ARM`, `CHESTPLATE_RIGHT_ARM`, `LEGGINGS_BODY`, `LEGGINGS_LEFT_LEG`,
---> `LEGGINGS_RIGHT_LEG`, `BOOTS_LEFT_LEG`, `BOOTS_RIGHT_LEG`, `LEFT_ELYRTA`, `RIGHT_ELYTRA`, `LEFT_ITEM`,
---> `RIGHT_ITEM`, `LEFT_PARROT`, `RIGHT_PARROT`
---<!--
---@field ALL VanillaModelGroup
---All armor pieces.
---> `HELMET_ITEM`, `HELMET_HEAD`, `HELMET_HAT`, `CHESTPLATE_BODY`, `CHESTPLATE_LEFT_ARM`, `CHESTPLATE_RIGHT_ARM`,
---> `LEGGINGS_BODY`, `LEGGINGS_LEFT_LEG`, `LEGGINGS_RIGHT_LEG`, `BOOTS_LEFT_LEG`, `BOOTS_RIGHT_LEG`
---<!--
---@field ARMOR VanillaModelGroup
---The player's body.
---<!--
---@field BODY VanillaModelPart
---Both armor boots.
---> `BOOTS_LEFT_LEG`, `BOOTS_RIGHT_LEG`
---<!--
---@field BOOTS VanillaModelGroup
---The left boot.
---<!--
---@field BOOTS_LEFT_LEG VanillaModelPart
---The right boot.
---<!--
---@field BOOTS_RIGHT_LEG VanillaModelPart
---Both cape versions.
---> `CAPE_MODEL`, `FAKE_CAPE`
---<!--
---@field CAPE VanillaModelGroup
---The vanilla cape.
---<!--
---@field CAPE_MODEL VanillaModelPart
---All chestplate pieces.
---> `CHESTPLATE_BODY`, `CHESTPLATE_LEFT_ARM`, `CHESTPLATE_RIGHT_ARM`
---<!--
---@field CHESTPLATE VanillaModelGroup
---The chestplate's body.
---<!--
---@field CHESTPLATE_BODY VanillaModelPart
---The chestplate's left arm.
---<!--
---@field CHESTPLATE_LEFT_ARM VanillaModelPart
---The chestplate's right arm.
---<!--
---@field CHESTPLATE_RIGHT_ARM VanillaModelPart
---Both elytra wings.
---> `LEFT_ELYRTA`, `RIGHT_ELYTRA`
---<!--
---@field ELYTRA VanillaModelGroup
---A custom copy of the cape.
---<!--
---@field FAKE_CAPE VanillaModelPart
---The player's hat layer.
---<!--
---@field HAT VanillaModelPart
---The player's head.
---<!--
---@field HEAD VanillaModelPart
---Both held items.
---> `LEFT_ITEM`, `RIGHT_ITEM`
---<!--
---@field HELD_ITEMS VanillaModelGroup
---All helmet pieces.
---> `HELMET_ITEM`, `HELMET_HEAD`, `HELMET_HAT`
---<!--
---@field HELMET VanillaModelGroup
---The helmet's second layer.
---<!--
---@field HELMET_HAT VanillaModelPart
---The helmet.
---<!--
---@field HELMET_HEAD VanillaModelPart
---Non-helmet items in the helmet slot.
---<!--
---@field HELMET_ITEM VanillaModelPart
---All inner layers of the player model.
---> `HEAD`, `BODY`, `LEFT_ARM`, `RIGHT_ARM`, `LEFT_LEG`, `RIGHT_LEG`
---<!--
---@field INNER_LAYER VanillaModelGroup
---The player's jacket layer.
---<!--
---@field JACKET VanillaModelPart
---The player's left arm.
---<!--
---@field LEFT_ARM VanillaModelPart
---The left elytra wing.
---<!--
---@field LEFT_ELYTRA VanillaModelPart
---The left held item.
---<!--
---@field LEFT_ITEM VanillaModelPart
---The player's left leg.
---<!--
---@field LEFT_LEG VanillaModelPart
---The player's left pants layer.
---<!--
---@field LEFT_PANTS VanillaModelPart
---The left parrot.
---<!--
---@field LEFT_PARROT VanillaModelPart
---The player's left sleeve.
---<!--
---@field LEFT_SLEEVE VanillaModelPart
---All leggings pieces.
---> `LEGGINGS_BODY`, `LEGGINGS_LEFT_LEG`, `LEGGINGS_RIGHT_LEG`
---<!--
---@field LEGGINGS VanillaModelGroup
---All outer layers of the player model.
---> `HAT`, `JACKET`, `LEFT_SLEEVE`, `RIGHT_SLEEVE`, `LEFT_PANTS`, `RIGHT_PANTS`
---<!--
---@field OUTER_LAYER VanillaModelGroup
---Both parrots.
---> `LEFT_PARROT`, `RIGHT_PARROT`
---<!--
---@field PARROTS VanillaModelGroup
---Both player model layers and cape.
---> `HEAD`, `BODY`, `LEFT_ARM`, `RIGHT_ARM`, `LEFT_LEG`, `RIGHT_LEG`, `HAT`, `JACKET`, `LEFT_SLEEVE`, `RIGHT_SLEEVE`,
---> `LEFT_PANTS`, `RIGHT_PANTS`, `CAPE_MODEL`, `FAKE_CAPE`
---<!--
---@field PLAYER VanillaModelGroup
---The player's right arm.
---<!--
---@field RIGHT_ARM VanillaModelPart
---The right elytra wing.
---<!--
---@field RIGHT_ELYTRA VanillaModelPart
---The right held item.
---<!--
---@field RIGHT_ITEM VanillaModelPart
---The player's right leg.
---<!--
---@field RIGHT_LEG VanillaModelPart
---The player's right pants layer.
---<!--
---@field RIGHT_PANTS VanillaModelPart
---The right parrot.
---<!--
---@field RIGHT_PARROT VanillaModelPart
---The player's right sleeve.
---<!--
---@field RIGHT_SLEEVE VanillaModelPart
local VanillaModelAPI
