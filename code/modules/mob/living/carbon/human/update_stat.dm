/mob/living/carbon/human/update_stat(reason = "none given")
	if(status_flags & GODMODE)
		return
	..(reason)
	if(stat != DEAD)
		switch(getBrainLoss())
			if(100 to 120)
				Weaken(20)
				create_debug_log("collapsed from brain damage, trigger reason: [reason]")
			if(120 to INFINITY)
				visible_message("<span class='alert'><B>[src]</B> goes limp, [p_their()] facial expression utterly blank.</span>")
				death()
				create_debug_log("died of brain damage, trigger reason: [reason]")
	else
		if(dna.species && dna.species.can_revive_by_healing)
			var/obj/item/organ/internal/brain/B = get_int_organ(/obj/item/organ/internal/brain)
			if(B)
				if((health >= (config.health_threshold_dead + config.health_threshold_crit) * 0.5) && getBrainLoss()<120)
					update_revive()
					create_debug_log("revived from healing, trigger reason: [reason]")