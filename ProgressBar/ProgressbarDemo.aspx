<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProgressbarDemo.aspx.cs" Inherits="ProgressBar.ProgressbarDemo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">
        var intervalId;
        function requestNewProgress() {
            //debugger;
            intervalId = window.setInterval(updateProgress, 100);
        }
        function updateProgress() {
            $.ajax({
                type: "POST",
                url: "ProgressbarDemo?GetProgress=true",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                    //debugger;                   
                    document.getElementById('<%= importBar.ClientID%>').style.width = data.progress + "%";
                    document.getElementById('<%= lblProcessingMessage.ClientID%>').innerHTML = data.ProcessingMessage;
                    document.getElementById('<%= lblDetailMessage.ClientID%>').innerHTML = data.DetailedMessage;

                    if (data.progress == "100") {
                        window.clearInterval(intervalId);
                    }
                }
            });
        }
    </script>


    <asp:Panel ID="Panel1" runat="server" DefaultButton="btnAutoMerge">
        <asp:UpdatePanel ID="updpnlMain" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="container">
                    <div class="row">
                        <div class="col-sm-10">
                            <div class="form-horizontal">
                                <div class="form-group form-group-sm">
                                    <div class="col-sm-12">
                                        <div class="progress progress-striped">
                                            <div id="importBar" runat="server" class="progress-bar progress-bar-info " role="progressbar" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
                                            </div>
                                        </div>

                                    </div>
                                </div>

                                <div class="form-group form-group-sm">
                                    <div class="col-sm-12">
                                        <asp:Label ID="lblProcessingMessage" runat="server" CssClass="form-control"></asp:Label>
                                    </div>

                                    <div class="col-sm-12">
                                        <asp:Label ID="lblDetailMessage" runat="server" CssClass="form-control"></asp:Label>
                                    </div>
                                </div>


                                <!--button-->
                                <div class="form-group form-group-sm">
                                    <div class="col-sm-3">
                                    </div>
                                    <div class="col-sm-9">
                                        <asp:Button ID="btnAutoMerge" runat="server" CssClass="btn btn-primary" Text="Start" OnClick="btnAutoMerge_Click"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <%--<asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick"  />--%>
            </Triggers>
        </asp:UpdatePanel>
    </asp:Panel>
</asp:Content>
