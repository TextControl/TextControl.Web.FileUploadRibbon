<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="tx_upload.index" %>

<%@ Register assembly="TXTextControl.Web, Version=30.0.1000.500, Culture=neutral, PublicKeyToken=6b83fe9a75cfb638" namespace="TXTextControl.Web" tagprefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TXTextControl.Web: Upload documents using Javascript</title>
    <script src="Scripts/jquery-2.1.4.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <input style="display: none; margin-bottom: 20px;" type="file" id="fileinput" />
        <cc1:TextControl ID="TextControl1" runat="server" />
        
        <script type="text/javascript">

            // this event is fired when everything Text Control releated
            // is loaded successfully
            TXTextControl.addEventListener("ribbonTabsLoaded", function (e) {
                addAction();
            });

            // cancel the normal "Load" action and call the click event
            // of the hidden input element
            function addAction() {
                document.getElementById("fileMnuItemOpen").addEventListener("click",
                    function (e) {
                        document.getElementById('fileinput').click();
                        e.cancelBubble = true;
                    });
            }

            // *****************************************************************
            // readDocument
            //
            // Desc: This function reads a file, converts it to a Base64 encoded
            // string and loads it into TX Text Control
            //
            // param input: The input HTML element
            // *****************************************************************
            function readDocument(input) {
                if (input.files && input.files[0]) {
                    var fileReader = new FileReader();
                    fileReader.onload = function (e) {

                        var streamType = TXTextControl.streamType.PlainText;

                        // set the StreamType based on the lower case extension
                        switch (input.value.split('.').pop().toLowerCase()) {
                            case 'doc':
                                streamType = TXTextControl.streamType.MSWord;
                                break;
                            case 'docx':
                                streamType = TXTextControl.streamType.WordprocessingML;
                                break;
                            case 'rtf':
                                streamType = TXTextControl.streamType.RichTextFormat;
                                break;
                            case 'htm':
                                streamType = TXTextControl.streamType.HTMLFormat;
                                break;
                            case 'tx':
                                streamType = TXTextControl.streamType.InternalUnicodeFormat;
                                break;
                            case 'pdf':
                                streamType = TXTextControl.streamType.AdobePDF;
                                break;
                        }

                        // load the document beginning at the Base64 data (split at comma)
                        TXTextControl.loadDocument(streamType, e.target.result.split(',')[1]);
                    };

                    // read the file and convert it to Base64
                    fileReader.readAsDataURL(input.files[0]);
                }
            }

            // call readDocument when a new document has been selected
            $("#fileinput").change(function () {
                readDocument(this);
            });
        </script>

    </div>
    </form>
</body>
</html>
