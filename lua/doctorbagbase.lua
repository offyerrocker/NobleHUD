Hooks:PreHook(DoctorBagBase, "take", "noblehud_docbagbase_take", function(self, unit)
	if not self._empty then
		NobleHUD:SetTeammateDowns(managers.network:session():local_peer():id(),0,true,false)
	end
end)
