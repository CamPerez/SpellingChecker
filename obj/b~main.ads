pragma Ada_95;
with System;
package ada_main is
   pragma Warnings (Off);

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: GPL 2015 (20150428-49)" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_main" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#95979030#;
   pragma Export (C, u00001, "mainB");
   u00002 : constant Version_32 := 16#fbff4c67#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#f72f352b#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#3ffc8e18#;
   pragma Export (C, u00004, "adaS");
   u00005 : constant Version_32 := 16#649a98f6#;
   pragma Export (C, u00005, "ada__calendarB");
   u00006 : constant Version_32 := 16#e67a5d0a#;
   pragma Export (C, u00006, "ada__calendarS");
   u00007 : constant Version_32 := 16#b612ca65#;
   pragma Export (C, u00007, "ada__exceptionsB");
   u00008 : constant Version_32 := 16#1d190453#;
   pragma Export (C, u00008, "ada__exceptionsS");
   u00009 : constant Version_32 := 16#a46739c0#;
   pragma Export (C, u00009, "ada__exceptions__last_chance_handlerB");
   u00010 : constant Version_32 := 16#3aac8c92#;
   pragma Export (C, u00010, "ada__exceptions__last_chance_handlerS");
   u00011 : constant Version_32 := 16#f4ce8c3a#;
   pragma Export (C, u00011, "systemS");
   u00012 : constant Version_32 := 16#a207fefe#;
   pragma Export (C, u00012, "system__soft_linksB");
   u00013 : constant Version_32 := 16#af945ded#;
   pragma Export (C, u00013, "system__soft_linksS");
   u00014 : constant Version_32 := 16#b01dad17#;
   pragma Export (C, u00014, "system__parametersB");
   u00015 : constant Version_32 := 16#8ae48145#;
   pragma Export (C, u00015, "system__parametersS");
   u00016 : constant Version_32 := 16#b19b6653#;
   pragma Export (C, u00016, "system__secondary_stackB");
   u00017 : constant Version_32 := 16#5faf4353#;
   pragma Export (C, u00017, "system__secondary_stackS");
   u00018 : constant Version_32 := 16#39a03df9#;
   pragma Export (C, u00018, "system__storage_elementsB");
   u00019 : constant Version_32 := 16#d90dc63e#;
   pragma Export (C, u00019, "system__storage_elementsS");
   u00020 : constant Version_32 := 16#41837d1e#;
   pragma Export (C, u00020, "system__stack_checkingB");
   u00021 : constant Version_32 := 16#7a71e7d2#;
   pragma Export (C, u00021, "system__stack_checkingS");
   u00022 : constant Version_32 := 16#393398c1#;
   pragma Export (C, u00022, "system__exception_tableB");
   u00023 : constant Version_32 := 16#5ad7ea2f#;
   pragma Export (C, u00023, "system__exception_tableS");
   u00024 : constant Version_32 := 16#ce4af020#;
   pragma Export (C, u00024, "system__exceptionsB");
   u00025 : constant Version_32 := 16#9cade1cc#;
   pragma Export (C, u00025, "system__exceptionsS");
   u00026 : constant Version_32 := 16#37d758f1#;
   pragma Export (C, u00026, "system__exceptions__machineS");
   u00027 : constant Version_32 := 16#b895431d#;
   pragma Export (C, u00027, "system__exceptions_debugB");
   u00028 : constant Version_32 := 16#472c9584#;
   pragma Export (C, u00028, "system__exceptions_debugS");
   u00029 : constant Version_32 := 16#570325c8#;
   pragma Export (C, u00029, "system__img_intB");
   u00030 : constant Version_32 := 16#f6156cf8#;
   pragma Export (C, u00030, "system__img_intS");
   u00031 : constant Version_32 := 16#b98c3e16#;
   pragma Export (C, u00031, "system__tracebackB");
   u00032 : constant Version_32 := 16#6af355e1#;
   pragma Export (C, u00032, "system__tracebackS");
   u00033 : constant Version_32 := 16#9ed49525#;
   pragma Export (C, u00033, "system__traceback_entriesB");
   u00034 : constant Version_32 := 16#f4957a4a#;
   pragma Export (C, u00034, "system__traceback_entriesS");
   u00035 : constant Version_32 := 16#8c33a517#;
   pragma Export (C, u00035, "system__wch_conB");
   u00036 : constant Version_32 := 16#efb3aee8#;
   pragma Export (C, u00036, "system__wch_conS");
   u00037 : constant Version_32 := 16#9721e840#;
   pragma Export (C, u00037, "system__wch_stwB");
   u00038 : constant Version_32 := 16#c2a282e9#;
   pragma Export (C, u00038, "system__wch_stwS");
   u00039 : constant Version_32 := 16#92b797cb#;
   pragma Export (C, u00039, "system__wch_cnvB");
   u00040 : constant Version_32 := 16#e004141b#;
   pragma Export (C, u00040, "system__wch_cnvS");
   u00041 : constant Version_32 := 16#6033a23f#;
   pragma Export (C, u00041, "interfacesS");
   u00042 : constant Version_32 := 16#ece6fdb6#;
   pragma Export (C, u00042, "system__wch_jisB");
   u00043 : constant Version_32 := 16#60740d3a#;
   pragma Export (C, u00043, "system__wch_jisS");
   u00044 : constant Version_32 := 16#769e25e6#;
   pragma Export (C, u00044, "interfaces__cB");
   u00045 : constant Version_32 := 16#4a38bedb#;
   pragma Export (C, u00045, "interfaces__cS");
   u00046 : constant Version_32 := 16#f4bb3578#;
   pragma Export (C, u00046, "system__os_primitivesB");
   u00047 : constant Version_32 := 16#441f0013#;
   pragma Export (C, u00047, "system__os_primitivesS");
   u00048 : constant Version_32 := 16#0881bbf8#;
   pragma Export (C, u00048, "system__task_lockB");
   u00049 : constant Version_32 := 16#9544bb54#;
   pragma Export (C, u00049, "system__task_lockS");
   u00050 : constant Version_32 := 16#1716ff24#;
   pragma Export (C, u00050, "system__win32S");
   u00051 : constant Version_32 := 16#1a9147da#;
   pragma Export (C, u00051, "system__win32__extS");
   u00052 : constant Version_32 := 16#12c8cd7d#;
   pragma Export (C, u00052, "ada__tagsB");
   u00053 : constant Version_32 := 16#ce72c228#;
   pragma Export (C, u00053, "ada__tagsS");
   u00054 : constant Version_32 := 16#c3335bfd#;
   pragma Export (C, u00054, "system__htableB");
   u00055 : constant Version_32 := 16#700c3fd0#;
   pragma Export (C, u00055, "system__htableS");
   u00056 : constant Version_32 := 16#089f5cd0#;
   pragma Export (C, u00056, "system__string_hashB");
   u00057 : constant Version_32 := 16#d25254ae#;
   pragma Export (C, u00057, "system__string_hashS");
   u00058 : constant Version_32 := 16#699628fa#;
   pragma Export (C, u00058, "system__unsigned_typesS");
   u00059 : constant Version_32 := 16#b44f9ae7#;
   pragma Export (C, u00059, "system__val_unsB");
   u00060 : constant Version_32 := 16#793ec5c1#;
   pragma Export (C, u00060, "system__val_unsS");
   u00061 : constant Version_32 := 16#27b600b2#;
   pragma Export (C, u00061, "system__val_utilB");
   u00062 : constant Version_32 := 16#586e3ac4#;
   pragma Export (C, u00062, "system__val_utilS");
   u00063 : constant Version_32 := 16#d1060688#;
   pragma Export (C, u00063, "system__case_utilB");
   u00064 : constant Version_32 := 16#d0c7e5ed#;
   pragma Export (C, u00064, "system__case_utilS");
   u00065 : constant Version_32 := 16#28f088c2#;
   pragma Export (C, u00065, "ada__text_ioB");
   u00066 : constant Version_32 := 16#1a9b0017#;
   pragma Export (C, u00066, "ada__text_ioS");
   u00067 : constant Version_32 := 16#10558b11#;
   pragma Export (C, u00067, "ada__streamsB");
   u00068 : constant Version_32 := 16#2e6701ab#;
   pragma Export (C, u00068, "ada__streamsS");
   u00069 : constant Version_32 := 16#db5c917c#;
   pragma Export (C, u00069, "ada__io_exceptionsS");
   u00070 : constant Version_32 := 16#84a27f0d#;
   pragma Export (C, u00070, "interfaces__c_streamsB");
   u00071 : constant Version_32 := 16#8bb5f2c0#;
   pragma Export (C, u00071, "interfaces__c_streamsS");
   u00072 : constant Version_32 := 16#845f5a34#;
   pragma Export (C, u00072, "system__crtlS");
   u00073 : constant Version_32 := 16#431faf3c#;
   pragma Export (C, u00073, "system__file_ioB");
   u00074 : constant Version_32 := 16#53bf6d5f#;
   pragma Export (C, u00074, "system__file_ioS");
   u00075 : constant Version_32 := 16#b7ab275c#;
   pragma Export (C, u00075, "ada__finalizationB");
   u00076 : constant Version_32 := 16#19f764ca#;
   pragma Export (C, u00076, "ada__finalizationS");
   u00077 : constant Version_32 := 16#95817ed8#;
   pragma Export (C, u00077, "system__finalization_rootB");
   u00078 : constant Version_32 := 16#bb3cffaa#;
   pragma Export (C, u00078, "system__finalization_rootS");
   u00079 : constant Version_32 := 16#ee0f26dd#;
   pragma Export (C, u00079, "system__os_libB");
   u00080 : constant Version_32 := 16#d7b69782#;
   pragma Export (C, u00080, "system__os_libS");
   u00081 : constant Version_32 := 16#1a817b8e#;
   pragma Export (C, u00081, "system__stringsB");
   u00082 : constant Version_32 := 16#8a719d5c#;
   pragma Export (C, u00082, "system__stringsS");
   u00083 : constant Version_32 := 16#09511692#;
   pragma Export (C, u00083, "system__file_control_blockS");
   u00084 : constant Version_32 := 16#238f5fd8#;
   pragma Export (C, u00084, "diccionari_simpleB");
   u00085 : constant Version_32 := 16#f21d8764#;
   pragma Export (C, u00085, "diccionari_simpleS");
   u00086 : constant Version_32 := 16#e12fd21d#;
   pragma Export (C, u00086, "pparaulaB");
   u00087 : constant Version_32 := 16#4d1c446e#;
   pragma Export (C, u00087, "pparaulaS");
   u00088 : constant Version_32 := 16#2b70b149#;
   pragma Export (C, u00088, "system__concat_3B");
   u00089 : constant Version_32 := 16#ffbed09f#;
   pragma Export (C, u00089, "system__concat_3S");
   u00090 : constant Version_32 := 16#fd83e873#;
   pragma Export (C, u00090, "system__concat_2B");
   u00091 : constant Version_32 := 16#f66e5bea#;
   pragma Export (C, u00091, "system__concat_2S");
   u00092 : constant Version_32 := 16#1e347caa#;
   pragma Export (C, u00092, "ada__wide_wide_charactersS");
   u00093 : constant Version_32 := 16#5d655666#;
   pragma Export (C, u00093, "ada__wide_wide_characters__handlingB");
   u00094 : constant Version_32 := 16#0910a976#;
   pragma Export (C, u00094, "ada__wide_wide_characters__handlingS");
   u00095 : constant Version_32 := 16#37434769#;
   pragma Export (C, u00095, "ada__wide_wide_characters__unicodeB");
   u00096 : constant Version_32 := 16#fb9c164a#;
   pragma Export (C, u00096, "ada__wide_wide_characters__unicodeS");
   u00097 : constant Version_32 := 16#27ccf663#;
   pragma Export (C, u00097, "system__utf_32B");
   u00098 : constant Version_32 := 16#6a4765f6#;
   pragma Export (C, u00098, "system__utf_32S");
   u00099 : constant Version_32 := 16#276453b7#;
   pragma Export (C, u00099, "system__img_lldB");
   u00100 : constant Version_32 := 16#07ec8553#;
   pragma Export (C, u00100, "system__img_lldS");
   u00101 : constant Version_32 := 16#bd3715ff#;
   pragma Export (C, u00101, "system__img_decB");
   u00102 : constant Version_32 := 16#5ae385e1#;
   pragma Export (C, u00102, "system__img_decS");
   u00103 : constant Version_32 := 16#9777733a#;
   pragma Export (C, u00103, "system__img_lliB");
   u00104 : constant Version_32 := 16#e581d9eb#;
   pragma Export (C, u00104, "system__img_lliS");
   u00105 : constant Version_32 := 16#2bce1226#;
   pragma Export (C, u00105, "system__memoryB");
   u00106 : constant Version_32 := 16#adb3ea0e#;
   pragma Export (C, u00106, "system__memoryS");
   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.wide_wide_characters%s
   --  ada.wide_wide_characters.handling%s
   --  interfaces%s
   --  system%s
   --  system.case_util%s
   --  system.case_util%b
   --  system.htable%s
   --  system.img_dec%s
   --  system.img_int%s
   --  system.img_int%b
   --  system.img_dec%b
   --  system.img_lld%s
   --  system.img_lli%s
   --  system.img_lli%b
   --  system.img_lld%b
   --  system.os_primitives%s
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.standard_library%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%b
   --  system.strings%s
   --  system.strings%b
   --  system.os_lib%s
   --  system.task_lock%s
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  ada.exceptions%s
   --  system.soft_links%s
   --  system.task_lock%b
   --  system.unsigned_types%s
   --  system.utf_32%s
   --  system.utf_32%b
   --  ada.wide_wide_characters.unicode%s
   --  ada.wide_wide_characters.unicode%b
   --  system.val_uns%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.val_uns%b
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_cnv%s
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%b
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.last_chance_handler%b
   --  system.concat_2%s
   --  system.concat_2%b
   --  system.concat_3%s
   --  system.concat_3%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.io_exceptions%s
   --  ada.tags%s
   --  ada.streams%s
   --  ada.streams%b
   --  interfaces.c%s
   --  system.exceptions%s
   --  system.exceptions%b
   --  system.exceptions.machine%s
   --  system.file_control_block%s
   --  system.file_io%s
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  ada.finalization%b
   --  system.win32%s
   --  system.win32.ext%s
   --  system.os_primitives%b
   --  ada.calendar%s
   --  ada.calendar%b
   --  system.memory%s
   --  system.memory%b
   --  system.standard_library%b
   --  system.secondary_stack%s
   --  system.file_io%b
   --  interfaces.c%b
   --  ada.tags%b
   --  system.soft_links%b
   --  system.os_lib%b
   --  ada.wide_wide_characters.handling%b
   --  system.secondary_stack%b
   --  system.traceback%s
   --  ada.exceptions%b
   --  system.traceback%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  pparaula%s
   --  pparaula%b
   --  diccionari_simple%s
   --  diccionari_simple%b
   --  main%b
   --  END ELABORATION ORDER


end ada_main;
