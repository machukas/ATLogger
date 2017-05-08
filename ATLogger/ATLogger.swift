//
//  ATLogger.swift
//  ATLogger
//
//  Created by Nicolas Landa on 8/5/17.
//  Copyright © 2017 Nicolas Landa. All rights reserved.
//

import Foundation

public struct ATLogger {
	
	internal static let dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		return dateFormatter
	}()
	
	/// Nivel de log
	public let severity: Severity
	/// Modo de la aplicación
	public let mode: AppMode
	
	///
	///
	/// - Parameters:
	///   - severity: Nivel del log
	///   - mode: Modo de la App, `nil` por defecto. Se autoconfigura con el flag 'DEBUG' del compilador si `nil`.
	public init(withLevel severity: Severity, mode: AppMode? = nil) {
		self.severity = severity
		
		if mode == nil {
			#if DEBUG
				self.mode = .debug
			#else
				self.mode = .release
			#endif
		} else {
			self.mode = mode!
		}
	}
	
	// MARK:- API
	
	/// Función de ayuda, registra en el log con nivel `debug` usando la función `log(text:severity:evenInReleaseMode)`
	public func debug(_ text: String, evenInReleaseMode writeAnyways: Bool = false, sourceFile fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
		self.log(text, in: .debug, evenInReleaseMode: writeAnyways)
	}
	
	/// Función de ayuda, registra en el log con nivel `info` usando la función `log(text:severity:evenInReleaseMode)`
	public func info(_ text: String, evenInReleaseMode writeAnyways: Bool = false, sourceFile fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
		self.log(text, in: .info, evenInReleaseMode: writeAnyways)
	}
	
	/// Función de ayuda, registra en el log con nivel `notice` usando la función `log(text:severity:evenInReleaseMode)`
	public func notice(_ text: String, evenInReleaseMode writeAnyways: Bool = false, sourceFile fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
		self.log(text, in: .notice, evenInReleaseMode: writeAnyways)
	}
	
	/// Función de ayuda, registra en el log con nivel `warning` usando la función `log(text:severity:evenInReleaseMode)`
	public func warning(_ text: String, evenInReleaseMode writeAnyways: Bool = false, sourceFile fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
		self.log(text, in: .warning, evenInReleaseMode: writeAnyways)
	}
	
	/// Función de ayuda, registra en el log con nivel `error` usando la función `log(text:severity:evenInReleaseMode)`
	public func error(_ text: String, evenInReleaseMode writeAnyways: Bool = false, sourceFile fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
		self.log(text, in: .error, evenInReleaseMode: writeAnyways)
	}
	
	/// Registra en el log el texto especificado. Si no se concreta el nivel de log, se tomará el utilizado al instanciar la clase.
	///
	/// - Parameters:
	///   - text: Texto a registrar
	///   - severity: Nivel de log
	///   - writeAnyways: Si ha de escribirse aunque no se esté en modo debug
	///   - fileName: Nombre del archivo que ejecuta este método
	///   - functionName: Nombre de la función que ejecuta este método
	///   - lineNumber: Número de linea del fichero donde está la función que ejecuta este método
	public func log(_ text: String, in severity: Severity? = nil, evenInReleaseMode writeAnyways: Bool = false, sourceFile fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
		var severity = severity
		if severity == nil { severity = self.severity }
		
		if shouldWrite(inSeverityLevel: severity!, evenInReleaseMode: writeAnyways) {
			self.write(text, sourceFile: fileName, functionName: functionName, lineNumber: lineNumber)
		}
	}
	
	// MARK:- Internal
	
	/// Escribe el log
	///
	/// - Parameter text: Texto a escribir
	internal func write(_ text: String, sourceFile fileName: String, functionName: String, lineNumber: Int) {
		debugPrint(self.formatOutput(text: text, sourceFile: fileName, functionName: functionName, lineNumber: lineNumber))
	}
	
	/// Establece las condiciones para que un mensaje sea escrito en el log
	///
	/// - Parameters:
	///   - severity: Nivel del log
	///   - writeAnyways: Si ha de escribirse independientemente del modo de la app
	/// - Returns: Si el mensaje ha de ser escrito
	internal func shouldWrite(inSeverityLevel severity: Severity, evenInReleaseMode writeAnyways: Bool) -> Bool {
		if severity.rawValue >= self.severity.rawValue {
			
			if writeAnyways || self.mode == .debug {
				return true
			}
		}
		
		return false
	}
	
	/// Crea el String a escribir
	///
	/// - Parameters:
	///   - text: Texto
	///   - fileName: Nombre del archivo
	///   - functionName: Nombre de la función
	///   - lineNumber: Línea
	/// - Returns: El string listo para pintar
	internal func formatOutput(text: String, sourceFile fileName: String, functionName: String, lineNumber: Int) -> String {
		let className = (fileName as NSString).lastPathComponent
		return "\(ATLogger.dateFormatter.string(from: Date())) [\(self.severity.description)] [\(functionName)] [\(className):\(lineNumber)]| \(text)"
	}
}
