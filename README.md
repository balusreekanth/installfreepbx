# installfreepbx


**This is one click freepbx installation for ubuntu system**

**This script will auto install freepbx 15 and asterisk 16 on a ubuntu 20.04 system with php 7.3**

### **Background :**

The default php version is 7.4 on ubuntu 20.04  . Freepbx 15 does not support  7.4 out of the box.

If you try to install freepbx 15 on ubuntu 20.04 with php 7.4 ,you may encounter php errors and warnings like below.

```
Array and string offset access syntax with curly braces is deprecated

chown [-f|–file FILE] [-m|–module MODULE]

In Process.php line 239:

The command “/usr/sbin/fwconsole chown” failed.

Exit Code: 255(Unknown error
```


### **What is the Solution ? :**

The solution is either  modifying freepbx installation files or downgrading php version on ubuntu.The latter is easy right ? (:


### **So what does this script do ? :**

This will install php 7.3 ,asterisk 16 and Freepbx 15 with minimal manual intervention for input .

Only couple of sections may require user input like selecting freepbx modules at makemenuselect (this could also be automated using commands , But I preferred leaving it to user)


Just download the script [directly](https://github.com/balusreekanth/installfreepbx/blob/main/freepbx.sh) or clone repository ,  chmod +x  and run the script .  If you need any help give me a shout (:














