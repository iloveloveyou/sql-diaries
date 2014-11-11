--
-- Query to activate and deactivate
--
-- @tested on: 11g, 10g
--

-- Deactivate
alter index IGIRECI1.INU_REBUT2 unusable;

-- Activate (Rebuild)
alter index IGIRECI1.INU_REBUT2 rebuild;

