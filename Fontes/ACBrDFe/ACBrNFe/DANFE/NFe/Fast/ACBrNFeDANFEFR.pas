{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emiss�o de Nota Fiscal}
{ eletr�nica - NFe - http://www.nfe.fazenda.gov.br                             }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       Andr� Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 11/08/2010: Itamar Luiz Bermond
|*  - Inicio do desenvolvimento
|* 24/08/2010: R�gys Silveira
|*  - Acerto da exporta��o para PDF
|*  - Acerto para checar se o relat�rio foi realmente preparado
|     antes de continuar a imprir ou gerar o PDF
|*  - Acerto nas propriedades do arquivo PDF
|* 26/08/2010: R�gys Silveira / Itamar Bermond
|*  - Acerto na propriedade "PreparedReport"
******************************************************************************}
{$I ACBr.inc}

unit ACBrNFeDANFEFR;

interface

uses
  SysUtils, Classes, Forms, ACBrNFeDANFEClass, ACBrNFeDANFEFRDM,
  pcnNFe, pcnConversao, frxClass;

type
  EACBrNFeDANFEFR = class(Exception);

	{$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF RTL230_UP}	
  TACBrNFeDANFEFR = class( TACBrNFeDANFEClass )
  private
    FdmDanfe: TACBrNFeFRClass;
    FEspessuraBorda: Integer;
    FMarcaDaguaMSG: string;
    FExpandirDadosAdicionaisAuto: boolean;

    function GetPreparedReport: TfrxReport;
    function GetPreparedReportEvento: TfrxReport;
    function GetPreparedReportInutilizacao: TfrxReport;

    function GetFastFile: String;
    function GetFastFileEvento: String;
    function GetFastFileInutilizacao: String;
    function GetPrintMode: TfrxPrintMode;
    function GetPrintOnSheet: Integer;
    function GetExibeCaptionButton: Boolean;
    function GetBorderIcon: TBorderIcons;
    function GetIncorporarBackgroundPdf: Boolean;
    function GetIncorporarFontesPdf: Boolean;
    procedure SetFastFile(const Value: String);
    procedure SetFastFileEvento(const Value: String);
    procedure SetFastFileInutilizacao(const Value: String);
    procedure SetPrintMode(const Value: TfrxPrintMode);
    procedure SetPrintOnSheet(const Value: Integer);
    procedure SetExibeCaptionButton(const Value: Boolean);
    procedure SetBorderIcon(const Value: TBorderIcons);
    procedure SetIncorporarBackgroundPdf(const Value: Boolean);
    procedure SetIncorporarFontesPdf(const Value: Boolean);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ImprimirDANFE(NFE: TNFe = nil); override;
    procedure ImprimirDANFEResumido(NFE: TNFe = nil); override;
    procedure ImprimirDANFEPDF(NFE: TNFe = nil); override;
    procedure ImprimirEVENTO(NFE: TNFe = nil); override;
    procedure ImprimirEVENTOPDF(NFE: TNFe = nil); override;
    procedure ImprimirINUTILIZACAO(NFE: TNFe = nil); override;
    procedure ImprimirINUTILIZACAOPDF(NFE: TNFe = nil); override;

    property PreparedReport: TfrxReport read GetPreparedReport;
    property PreparedReportEvento: TfrxReport read GetPreparedReportEvento;
    property PreparedReportInutilizacao: TfrxReport read GetPreparedReportInutilizacao;

  published
    property FastFile: String read GetFastFile write SetFastFile;
    property FastFileEvento: String read GetFastFileEvento write SetFastFileEvento;
    property FastFileInutilizacao: String read GetFastFileInutilizacao write SetFastFileInutilizacao;
    property EspessuraBorda: Integer read FEspessuraBorda write FEspessuraBorda;
    property MarcaDaguaMSG: string read FMarcaDaguaMSG write FMarcaDaguaMSG;
    property ExpandirDadosAdicionaisAuto: boolean read FExpandirDadosAdicionaisAuto write FExpandirDadosAdicionaisAuto;
    property IncorporarBackgroundPdf: Boolean read GetIncorporarBackgroundPdf write SetIncorporarBackgroundPdf;
    property IncorporarFontesPdf: Boolean read GetIncorporarFontesPdf write SetIncorporarFontesPdf;
    property PrintMode: TfrxPrintMode read GetPrintMode write SetPrintMode default pmDefault;
    property PrintOnSheet: Integer read GetPrintOnSheet write SetPrintOnSheet default 0;
    property BorderIcon: TBorderIcons read GetBorderIcon write SetBorderIcon;
    property ExibeCaptionButton: Boolean read GetExibeCaptionButton write SetExibeCaptionButton default False;
  end;

	{$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF RTL230_UP}
  TACBrNFeDANFCEFR = class( TACBrNFeDANFCEClass )
  private
    FdmDanfe: TACBrNFeFRClass;

    function GetPreparedReport: TfrxReport;
    function GetPreparedReportEvento: TfrxReport;
    function GetPreparedReportInutilizacao: TfrxReport;

    function GetFastFile: String;
    function GetFastFileEvento: String;
    function GetFastFileInutilizacao: String;
    function GetPrintMode: TfrxPrintMode;
    function GetPrintOnSheet: Integer;
    function GetExibeCaptionButton: Boolean;
    function GetBorderIcon: TBorderIcons;
    procedure SetFastFile(const Value: String);
    procedure SetFastFileEvento(const Value: String);
    procedure SetFastFileInutilizacao(const Value: String);
    procedure SetPrintMode(const Value: TfrxPrintMode);
    procedure SetPrintOnSheet(const Value: Integer);
    procedure SetExibeCaptionButton(const Value: Boolean);
    procedure SetBorderIcon(const Value: TBorderIcons);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ImprimirDANFE(NFE: TNFe = nil); override;
    procedure ImprimirDANFEResumido(NFE: TNFe = nil); override;
    procedure ImprimirDANFEPDF(NFE: TNFe = nil); override;
    procedure ImprimirEVENTO(NFE: TNFe = nil); override;
    procedure ImprimirEVENTOPDF(NFE: TNFe = nil); override;
    procedure ImprimirINUTILIZACAO(NFE: TNFe = nil); override;
    procedure ImprimirINUTILIZACAOPDF(NFE: TNFe = nil); override;

    property PreparedReport: TfrxReport read GetPreparedReport;
    property PreparedReportEvento: TfrxReport read GetPreparedReportEvento;
    property PreparedReportInutilizacao: TfrxReport read GetPreparedReportInutilizacao;

  published
    property FastFile: String read GetFastFile write SetFastFile;
    property FastFileEvento: String read GetFastFileEvento write SetFastFileEvento;
    property FastFileInutilizacao: String read GetFastFileInutilizacao write SetFastFileInutilizacao;
    property PrintMode: TfrxPrintMode read GetPrintMode write SetPrintMode default pmDefault;
    property PrintOnSheet: Integer read GetPrintOnSheet write SetPrintOnSheet default 0;
    property BorderIcon: TBorderIcons read GetBorderIcon write SetBorderIcon;
    property ExibeCaptionButton: Boolean read GetExibeCaptionButton write SetExibeCaptionButton default False;
  end;

implementation

uses
  ACBrNFe, ACBrUtil, StrUtils, pcnConversaoNFe;

constructor TACBrNFeDANFEFR.Create(AOwner: TComponent);
begin
  inherited create( AOwner );

  FEspessuraBorda := 1;
  FMarcaDaguaMSG:='';
  ExpandirDadosAdicionaisAuto:=false;
  FdmDanfe := TACBrNFeFRClass.Create(Self);

end;

destructor TACBrNFeDANFEFR.Destroy;
begin
  FdmDanfe.Free;
  inherited Destroy;
end;

function TACBrNFeDANFEFR.GetBorderIcon: TBorderIcons;
begin
  Result := FdmDanfe.BorderIcon;
end;

function TACBrNFeDANFEFR.GetExibeCaptionButton: Boolean;
begin
  Result := FdmDanfe.ExibeCaptionButton;
end;

function TACBrNFeDANFEFR.GetFastFile: String;
begin
  Result := FdmDanfe.FastFile;
end;

function TACBrNFeDANFEFR.GetFastFileEvento: String;
begin
  Result := FdmDanfe.FastFileEvento;
end;

function TACBrNFeDANFEFR.GetFastFileInutilizacao: String;
begin
  Result := FdmDanfe.FastFileInutilizacao;
end;

function TACBrNFeDANFEFR.GetIncorporarBackgroundPdf: Boolean;
begin
  Result := FdmDanfe.IncorporarBackgroundPdf;
end;

function TACBrNFeDANFEFR.GetIncorporarFontesPdf: Boolean;
begin
  Result := FdmDanfe.IncorporarFontesPdf;
end;

function TACBrNFeDANFEFR.GetPreparedReport: TfrxReport;
begin
  Result := FdmDanfe.GetPreparedReport;
end;

function TACBrNFeDANFEFR.GetPreparedReportEvento: TfrxReport;
begin
  Result := FdmDanfe.GetPreparedReportEvento;
end;

function TACBrNFeDANFEFR.GetPreparedReportInutilizacao: TfrxReport;
begin
  Result := FdmDanfe.GetPreparedReportInutilizacao;
end;

function TACBrNFeDANFEFR.GetPrintMode: TfrxPrintMode;
begin
  Result := FdmDanfe.PrintMode;
end;

function TACBrNFeDANFEFR.GetPrintOnSheet: Integer;
begin
  Result := FdmDanfe.PrintOnSheet;
end;

procedure TACBrNFeDANFEFR.SetBorderIcon(const Value: TBorderIcons);
begin
  FdmDanfe.BorderIcon := Value;
end;

procedure TACBrNFeDANFEFR.SetExibeCaptionButton(const Value: Boolean);
begin
  FdmDanfe.ExibeCaptionButton := Value;
end;

procedure TACBrNFeDANFEFR.SetFastFile(const Value: String);
begin
  FdmDanfe.FastFile := Value;
end;

procedure TACBrNFeDANFEFR.SetFastFileEvento(const Value: String);
begin
  FdmDanfe.FastFileEvento := Value;
end;

procedure TACBrNFeDANFEFR.SetFastFileInutilizacao(const Value: String);
begin
  FdmDanfe.FastFileInutilizacao := Value;
end;

procedure TACBrNFeDANFEFR.SetIncorporarBackgroundPdf(const Value: Boolean);
begin
  FdmDanfe.IncorporarBackgroundPdf := Value;
end;

procedure TACBrNFeDANFEFR.SetIncorporarFontesPdf(const Value: Boolean);
begin
  FdmDanfe.IncorporarFontesPdf := Value;
end;

procedure TACBrNFeDANFEFR.SetPrintMode(const Value: TfrxPrintMode);
begin
  FdmDanfe.PrintMode := Value;
end;

procedure TACBrNFeDANFEFR.SetPrintOnSheet(const Value: Integer);
begin
  FdmDanfe.PrintOnSheet := Value;
end;

procedure TACBrNFeDANFEFR.ImprimirDANFE(NFE: TNFe);
begin
  FdmDanfe.ImprimirDANFE(NFE);
end;

procedure TACBrNFeDANFEFR.ImprimirDANFEResumido(NFE: TNFe);
begin
  FdmDanfe.ImprimirDANFEResumido(NFE);
end;

procedure TACBrNFeDANFEFR.ImprimirDANFEPDF(NFE: TNFe);
begin
  FdmDanfe.ImprimirDANFEPDF(NFE);
  FPArquivoPDF := FdmDanfe.frxPDFExport.FileName;
end;

procedure TACBrNFeDANFEFR.ImprimirEVENTO(NFE: TNFe);
begin
  FdmDanfe.ImprimirEVENTO(NFE);
end;

procedure TACBrNFeDANFEFR.ImprimirEVENTOPDF(NFE: TNFe);
begin
  FdmDanfe.ImprimirEVENTOPDF(NFE);
  FPArquivoPDF := FdmDanfe.frxPDFExport.FileName;
end;

procedure TACBrNFeDANFEFR.ImprimirINUTILIZACAO(NFE: TNFe);
begin
  FdmDanfe.ImprimirINUTILIZACAO(NFE);
end;

procedure TACBrNFeDANFEFR.ImprimirINUTILIZACAOPDF(NFE: TNFe);
begin
  FdmDanfe.ImprimirINUTILIZACAOPDF(NFE);
  FPArquivoPDF := FdmDanfe.frxPDFExport.FileName;
end;

{ TACBrNFeDANFCEFR }

constructor TACBrNFeDANFCEFR.Create(AOwner: TComponent);
begin
  inherited;
  FdmDanfe := TACBrNFeFRClass.Create(Self);

end;

destructor TACBrNFeDANFCEFR.Destroy;
begin
  FdmDanfe.Free;
  inherited;
end;

function TACBrNFeDANFCEFR.GetBorderIcon: TBorderIcons;
begin
  Result := FdmDanfe.BorderIcon;
end;

function TACBrNFeDANFCEFR.GetExibeCaptionButton: Boolean;
begin
  Result := FdmDanfe.ExibeCaptionButton;
end;

function TACBrNFeDANFCEFR.GetFastFile: String;
begin
  Result := FdmDanfe.FastFile;
end;

function TACBrNFeDANFCEFR.GetFastFileEvento: String;
begin
  Result := FdmDanfe.FastFileEvento;
end;

function TACBrNFeDANFCEFR.GetFastFileInutilizacao: String;
begin
  Result := FdmDanfe.FastFileInutilizacao;
end;

function TACBrNFeDANFCEFR.GetPreparedReport: TfrxReport;
begin
  Result := FdmDanfe.GetPreparedReport;
end;

function TACBrNFeDANFCEFR.GetPreparedReportEvento: TfrxReport;
begin
  Result := FdmDanfe.GetPreparedReportEvento;
end;

function TACBrNFeDANFCEFR.GetPreparedReportInutilizacao: TfrxReport;
begin
  Result := FdmDanfe.GetPreparedReportInutilizacao;
end;

function TACBrNFeDANFCEFR.GetPrintMode: TfrxPrintMode;
begin
  Result := FdmDanfe.PrintMode;
end;

function TACBrNFeDANFCEFR.GetPrintOnSheet: Integer;
begin
  Result := FdmDanfe.PrintOnSheet;
end;

procedure TACBrNFeDANFCEFR.ImprimirDANFE(NFE: TNFe);
begin
  FdmDanfe.ImprimirDANFE(NFE);
end;

procedure TACBrNFeDANFCEFR.ImprimirDANFEPDF(NFE: TNFe);
begin
  FdmDanfe.ImprimirDANFEPDF(NFE);
  FPArquivoPDF := FdmDanfe.frxPDFExport.FileName;
end;

procedure TACBrNFeDANFCEFR.ImprimirDANFEResumido(NFE: TNFe);
begin
  FdmDanfe.ImprimirDANFEResumido(NFE);
end;

procedure TACBrNFeDANFCEFR.ImprimirEVENTO(NFE: TNFe);
begin
  FdmDanfe.ImprimirEVENTO(NFE);
end;

procedure TACBrNFeDANFCEFR.ImprimirEVENTOPDF(NFE: TNFe);
begin
  FdmDanfe.ImprimirEVENTOPDF(NFE);
  FPArquivoPDF := FdmDanfe.frxPDFExport.FileName;
end;

procedure TACBrNFeDANFCEFR.ImprimirINUTILIZACAO(NFE: TNFe);
begin
  FdmDanfe.ImprimirINUTILIZACAO(NFE);
end;

procedure TACBrNFeDANFCEFR.ImprimirINUTILIZACAOPDF(NFE: TNFe);
begin
  FdmDanfe.ImprimirINUTILIZACAOPDF(NFE);
  FPArquivoPDF := FdmDanfe.frxPDFExport.FileName;
end;

procedure TACBrNFeDANFCEFR.SetBorderIcon(const Value: TBorderIcons);
begin
  FdmDanfe.BorderIcon := Value;
end;

procedure TACBrNFeDANFCEFR.SetExibeCaptionButton(const Value: Boolean);
begin
  FdmDanfe.ExibeCaptionButton := Value;
end;

procedure TACBrNFeDANFCEFR.SetFastFile(const Value: String);
begin
  FdmDanfe.FastFile := Value;
end;

procedure TACBrNFeDANFCEFR.SetFastFileEvento(const Value: String);
begin
  FdmDanfe.FastFileEvento := Value;
end;

procedure TACBrNFeDANFCEFR.SetFastFileInutilizacao(const Value: String);
begin
  FdmDanfe.FastFileInutilizacao := Value;
end;

procedure TACBrNFeDANFCEFR.SetPrintMode(const Value: TfrxPrintMode);
begin
  FdmDanfe.PrintMode := Value;
end;

procedure TACBrNFeDANFCEFR.SetPrintOnSheet(const Value: Integer);
begin
  FdmDanfe.PrintOnSheet := Value;
end;

end.
