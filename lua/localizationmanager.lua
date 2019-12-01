local orig_loc = LocalizationManager.btn_macro
function LocalizationManager:btn_macro(...)
--should only ever return one value but it doesn't hurt to be safe
--assuming that the safety precautions are, themselves, safe.
	local result = {orig_loc(self,...)}
	if result and result[1] then
		result[1] = utf8.to_upper(result[1])
	end
	return unpack(result)
end