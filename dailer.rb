# "cDialer" this dialer allows you to make calls using your computer's modem.

# Copyright (C) 2011 Christopher Rankin

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, # USA.

require 'tk'
require 'tkextlib/tile'

root = TkRoot.new {title "Dialer"}
content = Tk::Tile::Frame.new(root) {padding "5 5 5 5"}.grid( :sticky => 'nsew')
TkGrid.columnconfigure root, 0, :weight => 1 
TkGrid.rowconfigure root, 0, :weight => 1   
TkOption.add '*tearOff', 0
ws = Tk.windowingsystem

menubar = TkMenu.new(root)

file = TkMenu.new(menubar)
file.add :command, :label => 'Open...', :command => proc{open_file}

menubar.add :cascade, :menu=>file, :label => "File"

root.menu(menubar)
   
lead_name = TkVariable.new
lead_address = TkVariable.new
lead_phone_number = TkVariable.new
lead_website = TkVariable.new
lead_email = TkVariable.new
lead_source = TkVariable.new
lead_company = TkVariable.new
lead_status = TkVariable.new

leads = %w{ Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark Bob Tammy Sue George Chris Bill Mark }

phone_leads = TkVariable.new(leads)

dial_num = TkVariable.new

num_to_dial = Tk::Tile::Entry.new(content) {
  width 15
  textvariable dial_num
}.grid(
  :column => 1,
  :row => 1,
  :sticky => 'we'
)

Tk::Tile::Button.new(content) {
  text 'Dial'
  command {dial_number(num_to_dial.value)}
}.grid( :column=>2, :row=>1)   

Tk::Tile::Button.new(content) {
  text 'Hangup'
  command {hangup_call}
}.grid( :column=>3, :row=>1)

Tk::Tile::Button.new(content) {
  text 'Mute'
  command {mute_call}
}.grid( :column=>4, :row=>1)

lf = Tk::Tile::Labelframe.new(content) { 
  text 'Lead Details' 
}.grid(:column=>1, :row=>2, :columnspan => 4)


# Row 1
Tk::Tile::Label.new(lf) {
  text 'Name:'    
}.grid( :column=>1, :row=>1)

Tk::Tile::Label.new(lf) {
  width 15
  textvariable lead_name    
}.grid( :column=>2, :row=>1)

Tk::Tile::Label.new(lf) {
  text 'Source:'    
}.grid( :column=>3, :row=>1)

Tk::Tile::Label.new(lf) {
  width 15
  textvariable lead_source    
}.grid( :column=>4, :row=>1)

# Row 2
Tk::Tile::Label.new(lf) {
  text 'Phone:'    
}.grid( :column=>1, :row=>2)

Tk::Tile::Label.new(lf) {
  width 15
  textvariable lead_phone_number   
}.grid( :column=>2, :row=>2)

Tk::Tile::Label.new(lf) {
  text 'Company:'    
}.grid( :column=>3, :row=>2)

Tk::Tile::Label.new(lf) {
  width 15
  textvariable lead_company    
}.grid( :column=>4, :row=>2)

# Row 3
Tk::Tile::Label.new(lf) {
  text 'Website:'    
}.grid( :column=>1, :row=>3)

Tk::Tile::Label.new(lf) {
  width 15
  textvariable lead_website    
}.grid( :column=>2, :row=>3)

Tk::Tile::Label.new(lf) {
  text 'Email:'    
}.grid( :column=>3, :row=>3)

Tk::Tile::Label.new(lf) {
  width 15
  textvariable lead_email    
}.grid( :column=>4, :row=>3)

# Row 4
Tk::Tile::Label.new(lf) {
  text 'Address:'    
}.grid( :column=>1, :row=>4)

Tk::Tile::Label.new(lf) {
  width 15
  textvariable lead_address    
}.grid( :column=>2, :row=>4, :rowspan=>3)

Tk::Tile::Label.new(lf) {
  text 'Status:'    
}.grid( :column=>3, :row=>4)

Tk::Tile::Label.new(lf) {
  width 15
  textvariable lead_status    
}.grid( :column=>4, :row=>4)

leads = TkListbox.new(content) {
  height 15
  width 52
  listvariable phone_leads  
}.grid(:column=>1, :row=>3, :columnspan=>4, :rowspan=>30)

leads.bind '<ListboxSelect>', proc{puts "Selecting"}
leads.bind 'Double-1', proc{puts "Double Click"}

# Put some space between all the widgets
TkWinfo.children(content).each { |w| 
  TkGrid.configure w, :padx => 5, :pady => 5  
}
TkWinfo.children(lf).each { |w| 
  TkGrid.configure w, :padx => 5, :pady => 5  
}

num_to_dial.focus
root.bind("Return") {dial_number(num_to_dial.value)}

def dial_number(number)
  puts "Dialing #{number}...\n"
end

def hangup_call
  puts "Hanging up."
end

def mute_call
  puts "Muting"
end

def open_file
  filename = Tk.getOpenFile
  puts "Opening #{filename}"
end

Tk.mainloop
