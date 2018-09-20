The daily tools that should be open at all times for automation:
  Einstein  (Einstein 360 only)
  RDS  (Comcast Gateway Access, a.k.a. Proxy Brower)
  Remedy  (have it set on "Find CR Customer" tab ready to accept accounts)
  Scout  (have it set on the "Customer Report" page ready to accept accounts)
  Avaya  (this will be automated for "AutoIn" and "AfterCall" respectively)
  Guided Paths  (this tool will autopopulate the dispo variables if you hit the
                 Perfect Call.)
				 
There are three programs:

S4 Checklist:
  Should be self explanatory, its basically a self scoring check list to help
  with Call Flow in hitting all the main points. You can customized the words to
  suit your particular verbage.

RDS Password Manager:
  This is so you can grab all the commonly used passwords and the beginning of
  your shift, and quickly login to respective modems throughout your work day
  with simple keystrokes.

Metric Master ("MM" for short):
  This is the main automation tool. Basically this is the process, once a call
  comes in, and you're past verification, and accutally logged into the account
  in Einstien, you will hit key combo [Ctrl + Alt + Win + m] to populate the
  MM tool with all the customer information. If the modem is online, the model,
  bootfile, and IP address should fill in as well, otherwise they'll be empty,
  and you'll have click the GREEN text boxes, after the modem comes online.
  Otherwise just select the appropriate entries from the dropdown menu.

  Click the banner to enable the info box, then you should be able to hover over
  any of the buttons, boxes, or colored controls within MM for a short
  description.

  There are caveats. This program isnt perfect. Example: if the online modem in
  Einstein is listed second or farther in the list, the model, bootfile, and IP
  may not always be found. You will have to pick them manually from the MM drop-
  down boxes, or copy and paste IP from einstein. I will continue to improve my
  code in a future versions.
  
  The other main caveat for Remedy Tickets is that only the first Ticket in the
  list will be opened automatically using [Ctrl + Alt + Win + v]. Which means
  "v" for resolve. Otherwise if you see the Assigned or Working ticket listed as
  second or farther in the list, you need to manually double click to open it,
  then hit [Ctrl + Alt + Win + b] to resolve it. Which means "b" for bypass
  initial auto opening and resolve the ticket opened manually. Sometimes you can
  sort the various Remedy Ticket columns to sort an assigned tick to first in
  the list. In any case, IT'S BEST TO LEAVE YOU MOUSE ALONE WHILE AUTOMATION IS
  MOVING THE MOUSE. Else something might not get properly clicked.

  In the MM tool, I have set most things to the default and most used values.
  And 90% of the time they'll do just fine. The only values I hand edit at times
  are Reported Issue and Resolution Action. But if you click the RED text boxes
  you can auto build a sentence structure instead of typing in notes. Otherwise
  hand edit your notes accordingly.

  Theres a lot more I can say, but I recommend practicing on a Notepad with the
  RDS tool to get a feel for how the Password Manager tool Works. And when you
  downtime, go into Einstein with training Account 8497202461365095 and practice
  the auto creation and resolution of tickets and get a quick feel for how the
  automation operates. Watch out for Avaya, it will put you in AfterCall auto-
  matically, so be sure to quickly go back to AutoIn.
  
  So things arent perfect. Do your best to get used to how the program operates,
  and it's limitations through trial and error. Feel free to ask any questions.


GENERAL PROCESS FLOW
  On a "perfect" call where modem is online and first in the list, this is how
  it should play out.

  - Gather all your daily modem Passwords with RDS Password Manager mouse hover
    capture method.
  - A call comes in, you verify and get into Einstien account.
  - Hit [Ctrl + Alt + Win + n] to fresh the MM program for (N)ew Customer.
  - After it grabs Einstein info it will prompt if you want to send account to
    Scout and Remedy? Click Yes.
  - It will populate Remedy and Scout with account, and RDS with IP address, and
	also place Avaya in AfterCall. If all the proper variables are turned green,
	it will also open Guided Paths session and auto fill the dispo info.	
  - If ticket does not already exist, you will get prompted to create one.
  - Click on the Green "Ticket Number" to populate CR# in MM after ticket has
    been created.
  - Edit all relevant MM fields accordingly to the siuation. Or use defaults.
  - When customer is happy, click "End Call" to auto resolve your ticket, and
	watch as everything else is done automatically.
  - However, the Guided Paths you'll have to close yourself.