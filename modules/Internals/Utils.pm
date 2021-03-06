##################################################################
# A module with basic functions
#
# Copyright (C) 2017 Andrey Ponomarenko's ABI Laboratory
#
# Written by Andrey Ponomarenko
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License or the GNU Lesser
# General Public License as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# and the GNU Lesser General Public License along with this program.
# If not, see <http://www.gnu.org/licenses/>.
##################################################################
use strict;

sub composeHTML_Head(@)
{
    my $Page = shift(@_);
    my $Title = shift(@_);
    my $Keywords = shift(@_);
    my $Description = shift(@_);
    my $Styles = shift(@_);
    
    my $Scripts = undef;
    if(@_) {
        $Scripts = shift(@_);
    }
    
    my $TopDir = getTop($Page);
    
    my $CommonStyles = "common.css";
    
    if($Styles)
    {
        $CommonStyles = "<link rel=\"stylesheet\" type=\"text/css\" href=\"$TopDir/css/$CommonStyles?v=1.2.1\" />";
        $Styles = "<link rel=\"stylesheet\" type=\"text/css\" href=\"$TopDir/css/$Styles?v=1.0\" />";
    }
    
    if($Scripts) {
        $Scripts = "<script type=\"text/javascript\" src=\"$TopDir/js/$Scripts\"></script>";
    }
    
    if($In::Opt{"GenRss"} and $Page eq "timeline") {
        $Styles .= "\n    <link rel='alternate' type='application/rss+xml' href='../../rss/".$In::Opt{"TargetLib"}."/feed.rss' />";
    }
    
    return "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">
    <html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\">
    <head>
    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />
    <meta name=\"keywords\" content=\"$Keywords\" />
    <meta name=\"description\" content=\"$Description\" />
    $CommonStyles
    $Styles
    $Scripts
    <title>
        $Title
    </title>
    
    </head>\n";
}

sub getTop($)
{
    my $Page = $_[0];
    
    my $Rel = "";
    
    if($Page=~/\A(changelog)\Z/) {
        $Rel = "../../..";
    }
    elsif($Page=~/\A(archives_report)\Z/) {
        $Rel = "../../../..";
    }
    elsif($Page=~/\A(timeline)\Z/) {
        $Rel = "../..";
    }
    elsif($Page=~/\A(global_index)\Z/) {
        $Rel = ".";
    }
    
    return $Rel;
}

return 1;
